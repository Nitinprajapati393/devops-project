terraform {
  backend "azurerm" {
    resource_group_name   = "example-resources"
    storage_account_name  = "devopss3pstorageaccount"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}