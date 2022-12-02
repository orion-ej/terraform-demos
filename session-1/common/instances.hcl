locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env = local.env_vars.locals.env
  base_source_url = "git::git@github.com:orion-ej/modules-demo.git//instances"
}

inputs = {
  project = local.project
}