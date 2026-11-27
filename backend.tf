
terraform {
  backend "azurerm" {
    resource_group_name  = "YOUR-TFSTATE-RESOURCE-GROUP"
    storage_account_name = "YOUR-TFSTATE-STORAGE-ACCOUNT"
    container_name       = "tfstate"
    key                  = "entra-id/terraform.tfstate"

    use_oidc         = true
    use_azuread_auth = true
  }
}
