
resource "random_string" "db_username" {
  length = 20
}

resource "random_password" "db_password" {
  special = false
  min_lower = 1
  min_upper = 1
  min_numeric = 1
  length = 20
}

# We would upload the DB password to a secret store somewhere, perhaps even as a complete connection string
