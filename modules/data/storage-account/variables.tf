variable "storage_account_name" {
  description = "Name of the storage account (must be globally unique)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier (Standard or Premium)"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)"
  type        = string
  default     = "GRS"
}

variable "default_network_rule" {
  description = "Default network rule (Allow or Deny)"
  type        = string
  default     = "Allow"
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
