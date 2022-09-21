terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + Incident.io Integration

# Details: https://github.com/indentapis/integrations/tree/fc629d5c057133dd97e04244485774a57fd10b71/packages/stable/indent-integration-incidentio
# Last Change: https://github.com/indentapis/integrations/commit/fc629d5c057133dd97e04244485774a57fd10b71

module "idt-incidentio-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-incidentio-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/incidentio-fc629d5c057133dd97e04244485774a57fd10b71-function.zip"
    deps_key     = "webhooks/aws/lambda/incidentio-fc629d5c057133dd97e04244485774a57fd10b71-deps.zip"
  }
  env = {
    INCIDENTIO_API_KEY             = var.incidentio_api_key
    AUTO_APPROVAL_DURATION         = var.auto_approval_duration
    AUTO_APPROVAL_INCIDENTIO_ROLES = var.auto_approval_incidentio_roles
  }
}

