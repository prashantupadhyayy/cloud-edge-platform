# Dev locals

locals {
  # Naming convention
  name_prefix = "${var.environment}-${var.location}"

  # Common naming patterns
  key_vault_name_pattern         = "kv${var.environment}"
  storage_account_name_pattern   = "st${var.environment}cloudedge"
  container_registry_name_pattern = "acr${var.environment}"
  aks_cluster_name_pattern       = "aks-${var.environment}"
  log_analytics_name_pattern     = "law-${var.environment}"
  app_insights_name_pattern      = "appinsights-${var.environment}"

  # Resource naming
  resource_group_name = "rg-cloud-edge-platform-${var.environment}"

  # Common tags that are applied to all resources
  environment_tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      Region      = var.location
      CreatedDate = timestamp()
    }
  )
}
