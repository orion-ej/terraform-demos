locals {
  project = var.project
  configuration = [
    for instance in var.configuration : [
      {
        instance_name          = instance.name
        ami                    = instance.ami
        instance_type          = instance.instance_type
        subnet_id              = instance.subnet_id
        vpc_security_group_ids = instance.vpc_security_group_ids
        ebs_block_devices      = instance.ebs_block_devices
      }
    ]
  ]
  instances = flatten(local.configuration)
}

resource "aws_instance" "instances" {
  for_each               = { for instance in local.instances : instance.instance_name => instance }
  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  vpc_security_group_ids = each.value.vpc_security_group_ids
  subnet_id              = each.value.subnet_id
  tags = {
    Name         = each.value.instance_name
    "managed-by" = "terraform"
    "project"    = local.project
  }
  dynamic "ebs_block_device" {
    for_each = each.value.ebs_block_devices
    content {
      device_name = ebs_block_device.value.device_name
      volume_size = ebs_block_device.value.volume_size
      volume_type = ebs_block_device.value.volume_type
    }
  }
}
