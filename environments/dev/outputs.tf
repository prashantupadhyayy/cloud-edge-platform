# Dev environment outputs

output "resource_group_id" {
  description = "ID of the resource group"
  value       = module.resource_group.id
}

output "vnet_id" {
  description = "ID of the VNet"
  value       = module.vnet.id
}

output "aks_cluster_id" {
  description = "ID of the AKS cluster"
  value       = module.aks.id
}

output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = module.aks.name
}

output "aks_fqdn" {
  description = "FQDN of the AKS cluster"
  value       = module.aks.fqdn
}

output "container_registry_id" {
  description = "ID of the container registry"
  value       = module.container_registry.id
}

output "container_registry_login_server" {
  description = "Login server of the container registry"
  value       = module.container_registry.login_server
}

output "log_analytics_workspace_id" {
  description = "ID of Log Analytics workspace"
  value       = module.log_analytics.id
}

output "app_insights_id" {
  description = "ID of Application Insights"
  value       = module.app_insights.id
}

output "key_vault_id" {
  description = "ID of Key Vault"
  value       = module.key_vault.id
}

output "key_vault_uri" {
  description = "URI of Key Vault"
  value       = module.key_vault.vault_uri
}

output "storage_account_id" {
  description = "ID of Storage Account"
  value       = module.storage_account.id
}

output "storage_account_name" {
  description = "Name of Storage Account"
  value       = module.storage_account.name
}

output "container_apps_environment_id" {
  description = "ID of Container Apps environment"
  value       = module.container_apps_environment.id
}

output "api_management_id" {
  description = "ID of API Management"
  value       = module.api_management.id
}

output "api_management_gateway_url" {
  description = "Gateway URL of API Management"
  value       = module.api_management.gateway_url
}
