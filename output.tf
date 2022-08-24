output "idt-incidentio-webhook-url" {
  value       = module.idt-incidentio-webhook.function_url
  description = "The URL of the deployed Lambda"
}

