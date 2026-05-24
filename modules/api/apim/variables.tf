variable "apim_name" {
  description = "Name of the API Management service"
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

variable "publisher_name" {
  description = "Publisher name for API Management"
  type        = string
}

variable "publisher_email" {
  description = "Publisher email for API Management"
  type        = string
}

variable "sku_name" {
  description = "SKU name (Developer, Standard, Premium, Consumption)"
  type        = string
  default     = "Developer"
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
