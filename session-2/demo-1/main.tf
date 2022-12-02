provider "aws" {
  region = "eu-west-1"
}


# Use aws_instance resource to create an EC2 instance
resource "aws_instance" "demo-instance" {
  # Specify instance type and ami
  ami           = "ami-006c19cfa0e8f4672"
  instance_type = "t4g.small"

  # Change root volume type, defaults to gp2
  root_block_device {
    volume_type = "gp3"
  }

  # Add a second volume
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_type = "gp3"
    volume_size = var.storage_size
  }

  # Set instance tags
  tags = {
    Name = "demo-instance-1"
  }
}


# Output the private IP address of the instance
output "instance_ip_addr" {
  value       = aws_instance.demo-instance.private_ip
  description = "The private IP address of the instance."
}
