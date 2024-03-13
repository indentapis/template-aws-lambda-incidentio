terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Incident.io Integration

# Details: https://github.com/indentapis/integrations/tree/c31c0a2f5371078d198ff8ae1a847404c628620e/packages/stable/indent-integration-incidentio
# Last Change: https://github.com/indentapis/integrations/commit/c31c0a2f5371078d198ff8ae1a847404c628620e

module "idt-incidentio-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-incidentio-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/incidentio-c31c0a2f5371078d198ff8ae1a847404c628620e-function.zip"
    deps_key     = "webhooks/aws/lambda/incidentio-c31c0a2f5371078d198ff8ae1a847404c628620e-deps.zip"
  }
  env = {
    INCIDENTIO_API_KEY             = var.incidentio_api_key
    AUTO_APPROVAL_DURATION         = var.auto_approval_duration
    AUTO_APPROVAL_INCIDENTIO_ROLES = var.auto_approval_incidentio_roles
  }
}

