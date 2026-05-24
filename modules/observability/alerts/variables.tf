variable "action_group_name" {
  description = "Name of the action group"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "short_name" {
  description = "Short name of the action group"
  type        = string
}

variable "alert_email" {
  description = "Email address for alerts"
  type        = string
}

variable "metric_alerts" {
  description = "Map of metric alerts"
  type = map(object({
    name               = string
    description        = string
    severity           = number
    enabled            = bool
    scopes             = list(string)
    metric_name        = string
    metric_namespace   = string
    aggregation        = string
    operator           = string
    threshold          = number
  }))
  default = {}
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
