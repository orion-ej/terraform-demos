locals {
  names    = var.names
  template = var.template
}

resource "aws_instance" "instances" {
  for_each      = local.names
  ami           = local.template.ami
  instance_type = local.template.instance_type
  tags = {
    Name = each.value
  }
}
