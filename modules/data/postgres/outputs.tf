output "id" {
  description = "ID of the PostgreSQL server"
  value       = azurerm_postgresql_server.this.id
}

output "name" {
  description = "Name of the PostgreSQL server"
  value       = azurerm_postgresql_server.this.name
}

output "fqdn" {
  description = "FQDN of the PostgreSQL server"
  value       = azurerm_postgresql_server.this.fqdn
}
