terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">=1.43.0"
    }
  }
}

resource "huaweicloud_vpc" "test" {
  name = format("%s-terraform", var.name_prefix)
  cidr = var.vpc_cidr
}

resource "huaweicloud_vpc_subnet" "test" {
  vpc_id = huaweicloud_vpc.test.id

  name        = format("%s-subnet-terraform", var.name_prefix)
  cidr        = cidrsubnet(var.vpc_cidr, 4, 1)
  gateway_ip  = cidrhost(cidrsubnet(var.vpc_cidr, 4, 1), 1)
  ipv6_enable = true
  # dns is required for cce node installing
  primary_dns   = var.primary_dns
  secondary_dns = var.secondary_dns
}

resource "huaweicloud_vpc_subnet" "eni_subnet" {
  vpc_id = huaweicloud_vpc.test.id

  name        = format("%s-eni-subnet-terraform", var.name_prefix)
  cidr        = cidrsubnet(var.vpc_cidr, 8, 2)
  gateway_ip  = cidrhost(cidrsubnet(var.vpc_cidr, 8, 2), 1)
  ipv6_enable = true
}

#define the security group and the sg rules
resource "huaweicloud_networking_secgroup" "test" {
  name                 = format("%s-secgroup-terraform", var.name_prefix)
  delete_default_rules = true
}

resource "huaweicloud_networking_secgroup_rule" "in_v4_icmp_all" {
  security_group_id = huaweicloud_networking_secgroup.test.id
  ethertype         = "IPv4"
  direction         = "ingress"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "huaweicloud_networking_secgroup_rule" "in_v6_icmp_all" {
  security_group_id = huaweicloud_networking_secgroup.test.id
  ethertype         = "IPv6"
  direction         = "ingress"
  protocol          = "icmp"
  remote_ip_prefix  = "::/0"
}

resource "huaweicloud_networking_secgroup_rule" "in_v4_elb_member" {
  security_group_id = huaweicloud_networking_secgroup.test.id
  ethertype         = "IPv4"
  direction         = "ingress"
  protocol          = "tcp"
  ports             = "8080,22"
  remote_ip_prefix  = huaweicloud_vpc.test.cidr
}

resource "huaweicloud_networking_secgroup_rule" "in_v4_samegroup" {
  security_group_id = huaweicloud_networking_secgroup.test.id
  ethertype         = "IPv4"
  direction         = "ingress"
  remote_group_id   = huaweicloud_networking_secgroup.test.id
}

resource "huaweicloud_networking_secgroup_rule" "in_v6_samegroup" {
  security_group_id = huaweicloud_networking_secgroup.test.id
  ethertype         = "IPv6"
  direction         = "ingress"
  remote_group_id   = huaweicloud_networking_secgroup.test.id
}

resource "huaweicloud_networking_secgroup_rule" "out_v4_all" {
  security_group_id = huaweicloud_networking_secgroup.test.id
  ethertype         = "IPv4"
  direction         = "egress"
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "huaweicloud_networking_secgroup_rule" "out_v6_all" {
  security_group_id = huaweicloud_networking_secgroup.test.id
  ethertype         = "IPv6"
  direction         = "egress"
  remote_ip_prefix  = "::/0"
}

