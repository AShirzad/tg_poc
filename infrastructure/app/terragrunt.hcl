include "root" {
  path = find_in_parent_folders()
}

dependency "db" {
  config_path                             = "../db"
  mock_outputs_allowed_terraform_commands = ["init", "validate"]
  mock_outputs                            = {
    db_settings = {
      name     = "",
      host     = "",
      username = "",
      password = ""
    }
  }
}

inputs = {
  # Maps to the variables defined in variables.tf
  db_name     = dependency.db.outputs.db_settings.name
  db_host     = dependency.db.outputs.db_settings.host
  db_user     = dependency.db.outputs.db_settings.username
  db_password = dependency.db.outputs.db_settings.password
}

