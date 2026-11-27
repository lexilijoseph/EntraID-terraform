
# Get current Terraform identity
data "azuread_client_config" "current" {}

# Create users
resource "azuread_user" "users" {
  for_each = var.users

  user_principal_name = each.value.user_principal_name
  display_name        = each.value.display_name
  password            = each.value.password

  account_enabled = true
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
