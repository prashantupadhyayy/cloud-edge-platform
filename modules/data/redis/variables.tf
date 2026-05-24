variable "cache_name" {
  description = "Name of the Redis cache"
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

variable "capacity" {
  description = "Redis cache capacity"
  type        = number
  default     = 1
}

variable "family" {
  description = "Redis cache family (C or P)"
  type        = string
  default     = "C"
}

variable "sku_name" {
  description = "Redis cache SKU"
  type        = string
  default     = "Basic"
}

variable "enable_non_ssl_port" {
  description = "Enable non-SSL port"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
