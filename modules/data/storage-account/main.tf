resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  https_traffic_only_enabled = true
  min_tls_version          = "TLS1_2"

  network_rules {
    default_action = var.default_network_rule
    bypass         = ["AzureServices"]
  }

  tags = var.common_tags
}
