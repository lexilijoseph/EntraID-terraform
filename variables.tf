
variable "tenant_id" {
  description = "Microsoft Entra tenant ID"
  type        = string
}

variable "users" {
  description = "Users to create"
  type = map(object({
    display_name        = string
    user_principal_name = string
    mail_nickname       = string
  }))
}

variable "group_name" {
  description = "Entra security group name"
  type        = string
}

variable "initial_password" {
  description = "Initial password for newly created users"
  type        = string
  sensitive   = true
}
