include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/common/instances.hcl"
  expose = true
}

terraform {
  # Specify tagged version of module
  source = "${include.envcommon.locals.base_source_url}?ref=v0.0.2"
  # Use the latest version of the module
  # source = "${include.envcommon.locals.base_source_url}"
}

# Define local variables 
locals {
}

# Define module inputs
inputs = {
}
