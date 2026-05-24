# Dev variables

# ============================================
# GENERAL
# ============================================
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "cloud-edge-platform"
  }
}

# ============================================
# RESOURCE GROUP
# ============================================
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-cloud-edge-platform-dev"
}

# ============================================
# NETWORKING
# ============================================
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-dev"
}

variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_aks_prefixes" {
  description = "Address prefixes for AKS subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "subnet_container_apps_prefixes" {
  description = "Address prefixes for Container Apps subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

# ============================================
# SECURITY
# ============================================
variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "current_user_object_id" {
  description = "Current user object ID for Key Vault access"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
  default     = "kvdev"
}

variable "enable_purge_protection" {
  description = "Enable purge protection on Key Vault"
  type        = bool
  default     = true
}

# ============================================
# STORAGE
# ============================================
variable "storage_account_name" {
  description = "Name of the storage account (must be globally unique)"
  type        = string
  default     = "stdevcloudedge"
}

variable "storage_account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "GRS"
}

# ============================================
# OBSERVABILITY
# ============================================
variable "log_analytics_workspace_name" {
  description = "Name of Log Analytics workspace"
  type        = string
  default     = "law-dev"
}

variable "log_analytics_sku" {
  description = "Log Analytics SKU"
  type        = string
  default     = "PerGB2018"
}

variable "log_analytics_retention" {
  description = "Log Analytics retention in days"
  type        = number
  default     = 30
}

variable "app_insights_name" {
  description = "Name of Application Insights"
  type        = string
  default     = "appinsights-dev"
}

# ============================================
# COMPUTE - Container Registry
# ============================================
variable "container_registry_name" {
  description = "Name of the container registry"
  type        = string
  default     = "acrdev"
}

variable "acr_sku" {
  description = "ACR SKU"
  type        = string
  default     = "Standard"
}

# ============================================
# COMPUTE - AKS Cluster
# ============================================
variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "aks-dev"
}

variable "aks_dns_prefix" {
  description = "DNS prefix for AKS"
  type        = string
  default     = "aks-dev"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.29"
}

variable "aks_node_count" {
  description = "Number of nodes in AKS cluster"
  type        = number
  default     = 3
}

variable "aks_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_D2s_v3"
}

# ============================================
# API MANAGEMENT
# ============================================
variable "apim_name" {
  description = "Name of API Management"
  type        = string
  default     = "apim-dev"
}

variable "publisher_name" {
  description = "Publisher name for API Management"
  type        = string
  default     = "Cloud Edge Platform"
}

variable "publisher_email" {
  description = "Publisher email for API Management"
  type        = string
  default     = "admin@example.com"
}

variable "apim_sku" {
  description = "API Management SKU"
  type        = string
  default     = "Developer"
}
