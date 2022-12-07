variable "names" {
  description = "Names for the instances"
  type        = set(string)
}

variable "template" {
  description = "Template for the instances"
  type = object({
    ami           = string
    instance_type = string
  })
}
