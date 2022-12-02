variable "configuration" {
  description = "Configuration of instances"
  type = list(object({
    name                   = string
    ami                    = string
    instance_type          = string
    vpc_security_group_ids = list(string)
    subnet_id              = string
    ebs_block_devices = optional(list(object({
      device_name = string
      volume_size = number
      volume_type = optional(string, "gp3")
    })))
  }))
  nullable = false
}

variable "project" {
  description = "Project name, should map to NICC code"
  default     = "demo"
}
