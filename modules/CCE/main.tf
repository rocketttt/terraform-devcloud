terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">=1.43.0"
    }
  }
}

resource "huaweicloud_vpc_eip" "cce_node_eip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "devcloud-demo-cce-node-eip-terraform"
    size        = 10
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

data "huaweicloud_availability_zones" "myaz" {}

resource "huaweicloud_cce_cluster" "mycce" {
  name                   = format("%s-cce-cluster-terraform", var.name_prefix)
  flavor_id              = "cce.s1.small"
  vpc_id                 = var.vpc_id
  subnet_id              = var.subnet_id
  container_network_type = "overlay_l2"
  charging_mode          = "postPaid"
}

resource "huaweicloud_cce_node" "mynode" {
  cluster_id        = huaweicloud_cce_cluster.mycce.id
  name              = format("%s-cce-node-terraform", var.name_prefix)
  flavor_id         = "c7n.xlarge.4"
  availability_zone = data.huaweicloud_availability_zones.myaz.names[0]
  password          = var.admin_password
  eip_id            = huaweicloud_vpc_eip.cce_node_eip.id
  os                = "CentOS 7.6"
  charging_mode     = "postPaid"
  root_volume {
    size       = 40
    volumetype = "SSD"
  }
  data_volumes {
    size       = 100
    volumetype = "SSD"
  }
}

