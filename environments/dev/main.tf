# Dev environment main Terraform configuration
# This file orchestrates all resources for the development environment

terraform {
  backend "azurerm" {
    # Configure with: terraform init -backend-config=key=<your-env>.tfstate
  }
}

# ============================================
# 1. RESOURCE GROUP
# ============================================
module "resource_group" {
  source = "../../modules/security/resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
  common_tags         = var.common_tags
}

# ============================================
# 2. NETWORKING - VNet, Subnets, NSG
# ============================================
module "vnet" {
  source = "../../modules/networking/vnet"

  vnet_name           = var.vnet_name
  location            = var.location
  resource_group_name = module.resource_group.name
  address_space       = var.address_space
  common_tags         = var.common_tags
}

module "subnet_aks" {
  source = "../../modules/networking/subnet"

  subnet_name          = "${var.environment}-aks-subnet"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.subnet_aks_prefixes
  common_tags          = var.common_tags
}

module "subnet_container_apps" {
  source = "../../modules/networking/subnet"

  subnet_name          = "${var.environment}-container-apps-subnet"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.vnet.name
  address_prefixes     = var.subnet_container_apps_prefixes
  common_tags          = var.common_tags
}

module "nsg" {
  source = "../../modules/networking/nsg"

  nsg_name            = "${var.environment}-nsg"
  location            = var.location
  resource_group_name = module.resource_group.name
  common_tags         = var.common_tags
}

# ============================================
# 3. SECURITY - Key Vault, Managed Identity, RBAC
# ============================================
module "key_vault" {
  source = "../../modules/security/keyvault"

  key_vault_name             = var.key_vault_name
  location                   = var.location
  resource_group_name        = module.resource_group.name
  tenant_id                  = var.tenant_id
  access_policy_object_id    = var.current_user_object_id
  purge_protection_enabled   = var.enable_purge_protection
  common_tags                = var.common_tags
}

module "managed_identity_aks" {
  source = "../../modules/security/managed-identity"

  identity_name       = "${var.environment}-aks-identity"
  location            = var.location
  resource_group_name = module.resource_group.name
  common_tags         = var.common_tags
}

module "managed_identity_acr" {
  source = "../../modules/security/managed-identity"

  identity_name       = "${var.environment}-acr-identity"
  location            = var.location
  resource_group_name = module.resource_group.name
  common_tags         = var.common_tags
}

# ============================================
# 4. STORAGE
# ============================================
module "storage_account" {
  source = "../../modules/data/storage-account"

  storage_account_name      = var.storage_account_name
  resource_group_name       = module.resource_group.name
  location                  = var.location
  account_tier              = var.storage_account_tier
  account_replication_type  = var.storage_account_replication_type
  default_network_rule      = "Allow"
  common_tags               = var.common_tags
}

# ============================================
# 5. OBSERVABILITY - Log Analytics, App Insights
# ============================================
module "log_analytics" {
  source = "../../modules/observability/log-analytics"

  workspace_name      = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = module.resource_group.name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_analytics_retention
  common_tags         = var.common_tags
}

module "app_insights" {
  source = "../../modules/observability/app-insights"

  app_insights_name   = var.app_insights_name
  location            = var.location
  resource_group_name = module.resource_group.name
  workspace_id        = module.log_analytics.id
  application_type    = "web"
  retention_in_days   = 90
  common_tags         = var.common_tags
}

# ============================================
# 6. COMPUTE - Container Registry
# ============================================
module "container_registry" {
  source = "../../modules/compute/acr"

  registry_name                = var.container_registry_name
  resource_group_name          = module.resource_group.name
  location                     = var.location
  sku                          = var.acr_sku
  public_network_access_enabled = true
  common_tags                  = var.common_tags
}

# ============================================
# 7. COMPUTE - Container Apps Environment
# ============================================
module "container_apps_environment" {
  source = "../../modules/compute/container-apps"

  environment_name              = "${var.environment}-cae"
  location                      = var.location
  resource_group_name           = module.resource_group.name
  log_analytics_workspace_id    = module.log_analytics.id
  subnet_id                     = module.subnet_container_apps.id
  common_tags                   = var.common_tags

  depends_on = [module.log_analytics]
}

# ============================================
# 8. COMPUTE - AKS Cluster
# ============================================
module "aks" {
  source = "../../modules/compute/aks"

  cluster_name              = var.aks_cluster_name
  location                  = var.location
  resource_group_name       = module.resource_group.name
  dns_prefix                = var.aks_dns_prefix
  kubernetes_version        = var.kubernetes_version
  node_pool_name            = "default"
  node_count                = var.aks_node_count
  vm_size                   = var.aks_vm_size
  subnet_id                 = module.subnet_aks.id
  managed_identity_id       = module.managed_identity_aks.id
  log_analytics_workspace_id = module.log_analytics.id
  common_tags               = var.common_tags

  depends_on = [module.log_analytics, module.managed_identity_aks]
}

# ============================================
# 9. API MANAGEMENT
# ============================================
module "api_management" {
  source = "../../modules/api/apim"

  apim_name          = var.apim_name
  location           = var.location
  resource_group_name = module.resource_group.name
  publisher_name     = var.publisher_name
  publisher_email    = var.publisher_email
  sku_name           = var.apim_sku
  common_tags        = var.common_tags
}
