# Dev providers

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    # Backend configuration must be provided during terraform init
    # Example:
    # terraform init -backend-config=resource_group_name=rg-terraform \
    #   -backend-config=storage_account_name=stterraform \
    #   -backend-config=container_name=tfstate \
    #   -backend-config=key=dev.tfstate
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}
