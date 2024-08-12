terraform {
  backend "azurerm" {
    resource_group_name   = "example-resources"
    storage_account_name  = "devopsprojects3cloudhub"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}