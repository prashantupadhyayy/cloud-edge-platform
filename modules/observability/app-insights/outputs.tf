output "id" {
  description = "ID of the Application Insights"
  value       = azurerm_application_insights.this.id
}

output "name" {
  description = "Name of the Application Insights"
  value       = azurerm_application_insights.this.name
}

output "instrumentation_key" {
  description = "Instrumentation key"
  value       = azurerm_application_insights.this.instrumentation_key
  sensitive   = true
}

output "app_id" {
  description = "Application ID"
  value       = azurerm_application_insights.this.app_id
}
