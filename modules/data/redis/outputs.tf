output "id" {
  description = "ID of the Redis cache"
  value       = azurerm_redis_cache.this.id
}

output "name" {
  description = "Name of the Redis cache"
  value       = azurerm_redis_cache.this.name
}

output "hostname" {
  description = "Hostname of the Redis cache"
  value       = azurerm_redis_cache.this.hostname
}

output "port" {
  description = "Port of the Redis cache"
  value       = azurerm_redis_cache.this.port
}

output "primary_access_key" {
  description = "Primary access key"
  value       = azurerm_redis_cache.this.primary_access_key
  sensitive   = true
}

output "connection_string" {
  description = "Connection string"
  value       = "${azurerm_redis_cache.this.hostname}:${azurerm_redis_cache.this.port}"
}
