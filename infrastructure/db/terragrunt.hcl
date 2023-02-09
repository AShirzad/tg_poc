include "root" {
  path = find_in_parent_folders()
}

prevent_destroy = coalesce(get_env("ENV_TYPE", ""), "QA") == "prod"
