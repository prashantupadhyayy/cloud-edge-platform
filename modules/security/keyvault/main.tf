resource "azurerm_key_vault" "this" {
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = var.tenant_id
  sku_name                   = var.sku_name
  enabled_for_disk_encryption = true
  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = 90

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.access_policy_object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Delete",
      "Update"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete"
    ]

    certificate_permissions = [
      "Get",
      "List",
      "Create",
      "Delete"
    ]
  }

  tags = var.common_tags
}
