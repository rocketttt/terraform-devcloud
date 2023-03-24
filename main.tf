data "huaweicloud_availability_zones" "test" {}

module "network_service" {
  source = "./modules/VPC"

  name_prefix = var.network_name_prefix
  vpc_cidr    = var.vpc_cidr
  # dns is required for cce node installing
  primary_dns   = var.primary_dns
  secondary_dns = var.secondary_dns
}

module "ecs_service" {
  source = "./modules/ECS"

  image_name        = var.image_name
  name_prefix       = var.ecs_name_prefix
  az_names          = data.huaweicloud_availability_zones.test.names
  subnet_id         = module.network_service.subnet_id
  security_group_id = module.network_service.security_group_id
  admin_password    = var.ecs_admin_password
}


module "cce_cluster" {
  source = "./modules/CCE"

  name_prefix         = var.cce_name_prefix
  vpc_id              = module.network_service.vpc_id
  subnet_id           = module.network_service.subnet_id
  admin_password      = var.node_admin_password
  image_name          = var.image_name
}
