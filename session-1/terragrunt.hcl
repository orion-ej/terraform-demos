locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")) 
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl"))
  account_name = local.account_vars.locals.account_name
  account_id = local.account_vars.locals.account_id
  region = local.region_vars.locals.region
}

generate "provider" {
  path = "_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "${local.region}"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id}:role/${local.account_name}-terraform"
  }
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    bucket = "terraform-state-${local.account_name}-${local.region}"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "${local.region}"
    encrypt = true
    dynamodb_table = "terraform-state-lock"
  }
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  local.account_vars.inputs,
  local.region_vars.inputs,
  local.project_vars.inputs,
)
