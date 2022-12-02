# Define our terraform backend
terraform {
  backend "s3" {
    bucket         = local.bucket_name
    key            = "non-prod/demo-3/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tf-locks"
  }
}

provider "aws" {
  region = "eu-west-1"
}

locals {
  # Rename to the bucket defined in the backend
  bucket_name = "root-tf-state"
  subnets = {
    a = "subnet-0deeb8c242fca55af"
    b = "subnet-05f8ec802c5604bdc"
    c = "subnet-0af92b5c5b654c6a7"
  }
  ami           = "ami-006c19cfa0e8f4672"
  instance_type = "t4g.small"
  sgs = [
    "sg-0bfc7250f6265dd70"
  ]
  storage_config = [
    {
      device_name = "/dev/sda1"
      volume_size = 10
    },
  ]
}

module "instances" {
  source  = "../modules/instances"
  project = "EG-0001"
  configuration = [
    # node 1
    {
      name                   = "demo-3-1"
      ami                    = local.ami
      instance_type          = local.instance_type
      subnet_id              = local.subnets.a
      vpc_security_group_ids = local.sgs
      ebs_block_devices      = local.storage_config
    },
    {
      name                   = "demo-3-2"
      ami                    = local.ami
      instance_type          = local.instance_type
      subnet_id              = local.subnets.b
      vpc_security_group_ids = local.sgs
      ebs_block_devices      = local.storage_config
    },
  ]
}
