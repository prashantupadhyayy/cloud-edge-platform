variable "account_name" {
  description = "Name of the CosmosDB account"
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

variable "consistency_level" {
  description = "Consistency level"
  type        = string
  default     = "Session"
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
