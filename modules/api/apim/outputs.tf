output "id" {
  description = "ID of the API Management service"
  value       = azurerm_api_management.this.id
}

output "name" {
  description = "Name of the API Management service"
  value       = azurerm_api_management.this.name
}

output "gateway_url" {
  description = "Gateway URL"
  value       = azurerm_api_management.this.gateway_url
}
