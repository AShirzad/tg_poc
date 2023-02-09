locals {
  # Can specify a default
  env_type    = coalesce(get_env("ENV_TYPE", ""), "QA")
  # Must has specified the environment name.
  # As this is an env variable set before running the executable it will be available as an
  # input variable called "ENV_NAME" to all modules
  env_name    = get_env("ENV_NAME")
  module_name = replace(path_relative_to_include(), "/", "-")
  config_path = "${get_parent_terragrunt_dir()}/../config/${path_relative_to_include()}"
}

terraform {
  extra_arguments "reconfigure" {
    commands = [
      "init",
    ]

    arguments = ["-reconfigure"]

  }

  extra_arguments "context_variables" {
    commands           = get_terraform_commands_that_need_vars()
    required_var_files = ["${local.config_path}/common.tfvars"]
    optional_var_files = [
      "${local.config_path}/${local.env_type}.tfvars",
      "${local.config_path}/${local.env_type}-${local.env_name}.tfvars",
    ]
    env_vars           = {
      # We can pass these in as inputs instead, but if it's ambient it will be available to all modules without
      # explicit binding
      "TF_VAR_env_type" = local.env_type
      "TF_VAR_env_name" = local.env_name
    }
  }

  before_hook "FYI" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]
    execute = ["echo", "Running ${local.module_name} terraform for ${local.env_type} environment ${local.env_name}"]

  }
  before_hook "reconfigure" {
    commands = [
      "init"
    ]
    execute = ["echo", "Reconfiguring ${local.module_name} terraform for ${local.env_type} environment ${local.env_name}"]

  }
}
remote_state {
  backend  = "local"
  generate = {
    path = "./backend.tf"
    if_exists: "overwrite_terragrunt"
  }
  config = {
    # This can be a unique key in the same bucket, doesn't have to be terraform.tfstate
    path = "${get_parent_terragrunt_dir()}/../state/${local.env_type}-${local.env_name}-${local.module_name}.tfstate"
  }
}
