variable "server_name" {
  description = "Name of the PostgreSQL server"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "admin_username" {
  description = "Administrator username"
  type        = string
}

variable "admin_password" {
  description = "Administrator password"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "SKU name"
  type        = string
  default     = "B_Gen5_2"
}

variable "storage_mb" {
  description = "Storage in MB"
  type        = number
  default     = 51200
}

variable "postgres_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "11"
}

variable "backup_retention_days" {
  description = "Backup retention days"
  type        = number
  default     = 7
}

variable "geo_redundant_backup" {
  description = "Enable geo-redundant backup"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
