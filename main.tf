terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Incident.io Integration

# Details: https://github.com/indentapis/integrations/tree/df7a83d97d7220dc20566871e81d90a20ec160e0/packages/stable/indent-integration-incidentio
# Last Change: https://github.com/indentapis/integrations/commit/df7a83d97d7220dc20566871e81d90a20ec160e0

module "idt-incidentio-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-incidentio-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/incidentio-df7a83d97d7220dc20566871e81d90a20ec160e0-function.zip"
    deps_key     = "webhooks/aws/lambda/incidentio-df7a83d97d7220dc20566871e81d90a20ec160e0-deps.zip"
  }
  env = {
    INCIDENTIO_API_KEY             = var.incidentio_api_key
    AUTO_APPROVAL_DURATION         = var.auto_approval_duration
    AUTO_APPROVAL_INCIDENTIO_ROLES = var.auto_approval_incidentio_roles
  }
}

