terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Incident.io Integration

# Details: https://github.com/indentapis/integrations/tree/1fd2f24096392db60449260ccc85d84bc247ec14/packages/stable/indent-integration-incidentio
# Last Change: https://github.com/indentapis/integrations/commit/1fd2f24096392db60449260ccc85d84bc247ec14

module "idt-incidentio-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-incidentio-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/incidentio-1fd2f24096392db60449260ccc85d84bc247ec14-function.zip"
    deps_key     = "webhooks/aws/lambda/incidentio-1fd2f24096392db60449260ccc85d84bc247ec14-deps.zip"
  }
  env = {
    INCIDENTIO_API_KEY             = var.incidentio_api_key
    AUTO_APPROVAL_DURATION         = var.auto_approval_duration
    AUTO_APPROVAL_INCIDENTIO_ROLES = var.auto_approval_incidentio_roles
  }
}

