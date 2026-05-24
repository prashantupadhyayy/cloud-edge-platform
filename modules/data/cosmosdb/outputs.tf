output "id" {
  description = "ID of the CosmosDB account"
  value       = azurerm_cosmosdb_account.this.id
}

output "name" {
  description = "Name of the CosmosDB account"
  value       = azurerm_cosmosdb_account.this.name
}

output "endpoint" {
  description = "Endpoint of the CosmosDB account"
  value       = azurerm_cosmosdb_account.this.endpoint
}

output "primary_key" {
  description = "Primary key of the CosmosDB account"
  value       = azurerm_cosmosdb_account.this.primary_key
  sensitive   = true
}
