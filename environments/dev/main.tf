module "resource_group" {
  source = "../../modules/resource_group"

  resource_group_name = var.resource_group_name

  location = var.location

  tags = var.tags
}

module "vnet" {
  source = "../../modules/networking/vnet"

  vnet_name = var.vnet_name

  resource_group_name = module.resource_group.resource_group_name

  location = var.location

  address_space = var.address_space

  tags = var.tags
}

module "subnet" {
  source = "../../modules/networking/subnet"

  resource_group_name = module.resource_group.resource_group_name

  vnet_name = module.vnet.vnet_name

  subnets = var.subnets
}

module "nsg" {
  source = "../../modules/networking/nsg"

  resource_group_name = module.resource_group.resource_group_name

  location = var.location

  tags = var.tags

  nsgs = var.nsgs
}