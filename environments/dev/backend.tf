# Dev backend configuration
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-001"
    storage_account_name = "tfstateplatform0001"
    container_name       = "tfstate"
    key                  = "dev.tfstate"
  }
}