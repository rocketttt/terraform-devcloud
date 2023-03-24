################################################################
###  Authentication
variable "region" {
  description = "The region name"
}

variable "access_key" {
  description = "The access key for authentication"
}

variable "secret_key" {
  description = "The secret key for authentication"
}

variable "enterprise_project_id" {
  description = "The secret key for authentication"
}

################################################################
###  Network
variable "network_name_prefix" {
  description = "The name prefix for all VPC resources within HUAWEI Cloud"
}

variable "vpc_cidr" {
  description = "The CIDR of the VPC resource within HUAWEI Cloud"
  default     = "172.16.0.0/16"
}
################################################################
###  ECS

variable "image_name" {
  description = "The name of IMS image within HUAWEI Cloud"
  default     = "Ubuntu 18.04 server 64bit"
}

variable "ecs_name_prefix" {
  description = "The name prefix for all ECS resources within HUAWEI Cloud"
}

variable "ecs_admin_password" {
  description = "The password of ECS instance administrator within HUAWEI Cloud"
}

################################################################

### CCE
variable "node_admin_password" {
  description = "The password of node instance administrator within HUAWEI Cloud"
}

variable "primary_dns" {
  default = "100.125.1.250"
}

variable "secondary_dns" {
  default = "100.125.21.250"
}

variable "cce_name_prefix" {
  description = "The name prefix for all CCE resources within HUAWEI Cloud"
}