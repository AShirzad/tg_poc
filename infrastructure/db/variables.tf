variable "env_name" {
  type        = string
  description = "Name of the environment we're deploying to"
  validation {
    condition = length(var.env_name) > 3
    error_message = "Environment names must be at least 3 characters long"
  }
}
variable "env_type" {
  type        = string
  description = "Type of the environment we're deploying to"
  validation {
    condition     = contains(["QA", "staging", "production"], var.env_type)
    error_message = "Must be a valid environment type"
  }
}

variable db_name {
  type = string
}

variable db_host {
  type = string
}
