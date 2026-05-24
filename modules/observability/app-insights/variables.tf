variable "app_insights_name" {
  description = "Name of the Application Insights instance"
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

variable "workspace_id" {
  description = "ID of Log Analytics workspace"
  type        = string
}

variable "application_type" {
  description = "Application type (web, other)"
  type        = string
  default     = "web"
}

variable "retention_in_days" {
  description = "Retention period in days"
  type        = number
  default     = 90
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
