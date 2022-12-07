terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Incident.io Integration

# Details: https://github.com/indentapis/integrations/tree/1c96c5ecb61ba6fe8f5dd76ef2a2614cc454117c/packages/stable/indent-integration-incidentio
# Last Change: https://github.com/indentapis/integrations/commit/1c96c5ecb61ba6fe8f5dd76ef2a2614cc454117c

module "idt-incidentio-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-incidentio-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/incidentio-1c96c5ecb61ba6fe8f5dd76ef2a2614cc454117c-function.zip"
    deps_key     = "webhooks/aws/lambda/incidentio-1c96c5ecb61ba6fe8f5dd76ef2a2614cc454117c-deps.zip"
  }
  env = {
    INCIDENTIO_API_KEY             = var.incidentio_api_key
    AUTO_APPROVAL_DURATION         = var.auto_approval_duration
    AUTO_APPROVAL_INCIDENTIO_ROLES = var.auto_approval_incidentio_roles
  }
}

