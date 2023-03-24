variable "name_prefix" {
  description = "The name prefix for VPC resources within HUAWEI Cloud"
}

variable "vpc_cidr" {
  description = "The CIDR of the Huaweicloud VPC"
}

variable "primary_dns" {
  default = "100.125.1.250"
}

variable "secondary_dns" {
  default = "100.125.21.250"
}