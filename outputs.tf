
output "created_users" {
  value = {
    for key, user in azuread_user.users :
    key => user.user_principal_name
  }
}

output "security_group_id" {
  value = azuread_group.security_group.object_id
}
