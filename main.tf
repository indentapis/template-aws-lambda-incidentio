terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Incident.io Integration

# Details: https://github.com/indentapis/integrations/tree/0a57365f403b55b0d6a0937f9da5d1639c6c6e5e/packages/stable/indent-integration-incidentio
# Last Change: https://github.com/indentapis/integrations/commit/0a57365f403b55b0d6a0937f9da5d1639c6c6e5e

module "idt-incidentio-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-incidentio-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/incidentio-0a57365f403b55b0d6a0937f9da5d1639c6c6e5e-function.zip"
    deps_key     = "webhooks/aws/lambda/incidentio-0a57365f403b55b0d6a0937f9da5d1639c6c6e5e-deps.zip"
  }
  env = {
    AUTO_APPROVAL_DURATION         = var.auto_approval_duration
    AUTO_APPROVAL_INCIDENTIO_ROLES = var.auto_approval_incidentio_roles
  }
}

