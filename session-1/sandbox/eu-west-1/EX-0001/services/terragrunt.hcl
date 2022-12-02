include "root" {
  path = find_in_parent_folders()
}

include "common" {
  path   = "${dirname(find_in_parent_folders())}/common/instances.hcl"
  expose = true
}

terraform {
  # Specify tagged version of module
  # source = "${include.common.locals.base_source_url}?ref=v0.0.2"
  # Use the latest version of the module
  source = "${include.common.locals.base_source_url}"
}

# Define local variables 
locals {
  ami = "ami-07e1daca3ee9095b3"
  instance_type = "t4g.small"
}

# Define module inputs
inputs = {
  configuration = [
    {
      name                   = "demo-1"
      ami                    = local.ami
      instance_type          = local.instance_type
      vpc_security_group_ids = []
      subnet_id              = ""
      ebs_block_devices = [
        {
          device_name = "/dev/sda1"
          volume_size = 8
          tags = {}
        },
      ]
      tags = {
        "deploy" = "demo"
      }
    },
    {
      name                   = "demo-2"
      ami                    = local.ami
      instance_type          = local.instance_type
      vpc_security_group_ids = []
      subnet_id              = ""
      ebs_block_devices = [
        {
          device_name = "/dev/sda1"
          volume_size = 8
          tags = {}
        },
      ]
      tags = {
        "deploy" = "demo"
      }
    },
  ]
}
