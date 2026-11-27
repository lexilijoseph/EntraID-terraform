
# Get current Terraform identity
data "azuread_client_config" "current" {}

# Create users
resource "azuread_user" "users" {
  for_each = var.users

  display_name        = each.value.display_name
  user_principal_name = each.value.user_principal_name
  mail_nickname       = each.value.mail_nickname

  password                 = var.initial_password
  force_password_change    = true
  account_enabled          = true

  owners = [
    data.azuread_client_config.current.object_id
  ]
}

# Create security group
resource "azuread_group" "security_group" {
  display_name     = var.group_name
  description      = "Created and managed by Terraform CI/CD"
  security_enabled = true
  mail_enabled     = false

  owners = [
    data.azuread_client_config.current.object_id
  ]

  members = [
    for user in azuread_user.users : user.object_id
  ]
}
