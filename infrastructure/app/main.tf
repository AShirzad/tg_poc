locals {
  # Just here as an example, we woudn't really build it here
  pg_connectionstring = "postgresql://${var.db_user}:${var.db_password}@${var.db_host}/${var.db_name}"
}
