resource "azurerm_container_registry" "this" {
  name                = var.registry_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  admin_enabled = false

  network_rule_bypass_option       = "AzureServices"
  public_network_access_enabled    = var.public_network_access_enabled

  tags = var.common_tags
}
