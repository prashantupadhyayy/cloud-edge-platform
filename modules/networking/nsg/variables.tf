variable "nsg_name" {
  description = "Name of the network security group"
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

variable "allowed_source_address" {
  description = "Allowed source address for inbound traffic"
  type        = string
  default     = "*"
}

variable "associate_with_subnet" {
  description = "Whether to associate NSG with a subnet"
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "ID of the subnet to associate with"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
