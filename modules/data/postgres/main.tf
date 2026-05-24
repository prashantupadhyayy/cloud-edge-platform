resource "azurerm_postgresql_server" "this" {
  name                = var.server_name
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password

  sku_name   = var.sku_name
  storage_mb = var.storage_mb
  version    = var.postgres_version

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup

  public_network_access_enabled    = var.public_network_access_enabled
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  tags = var.common_tags
}
