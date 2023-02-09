output "db_settings" {
  value = {
    name: var.db_name
    host: var.db_host
    username: random_string.db_username
    password: random_password.db_password
  }
  sensitive = true
}
