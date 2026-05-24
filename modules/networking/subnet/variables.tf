variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "service_endpoints" {
  description = "Service endpoints to enable"
  type        = list(string)
  default     = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ServiceBus"]
}
