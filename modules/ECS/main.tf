terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">=1.43.0"
    }
  }
}

data "huaweicloud_images_image" "test" {
  architecture = "x86"
  os_version   = "CentOS 7.6 64bit"
  visibility   = "public"
  most_recent  = true
}

data "huaweicloud_compute_flavors" "test" {
  availability_zone = var.az_names[0]

  performance_type = "normal"
  cpu_core_count   = 2
  memory_size      = 4
}

resource "huaweicloud_compute_instance" "test" {
  image_id  = data.huaweicloud_images_image.test.id
  flavor_id = data.huaweicloud_compute_flavors.test.ids[0]

  name              = format("%s-ecs-terraform", var.name_prefix)
  admin_pass        = var.admin_password
  availability_zone = var.az_names[0]
  charging_mode     = "postPaid"
  security_group_ids = [
    var.security_group_id,
  ]

  system_disk_type = "SSD"
  system_disk_size = 40

  data_disks {
    type = "SSD"
    size = 40
  }

  network {
    uuid = var.subnet_id
  }
}

resource "huaweicloud_vpc_eip" "myeip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = format("%s-ecs-eip-terraform", var.name_prefix)
    size        = 8
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

resource "huaweicloud_compute_eip_associate" "associated" {
  public_ip   = huaweicloud_vpc_eip.myeip.address
  instance_id = huaweicloud_compute_instance.test.id
}


