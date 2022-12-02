locals {
  output = {
    for instance in aws_instance.instances : instance.id => {
      id         = instance.id
      name       = instance.tags.Name
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
    }
  }
}

output "instances" {
  value       = local.output
  description = "Instances created by this module"
}
