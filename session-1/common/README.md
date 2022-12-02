# Module Definition

### example-module.hcl

```hcl
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env = local.env_vars.locals.env
  # Define where to pull the module from
  # e.g base_source_url = "git::git@github.com:<username>/<repo>.git//<module>"
  base_source_url = ""
}

# Set inputs for the module
inputs = {
}
```
