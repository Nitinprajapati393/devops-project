terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

resource "azurerm_resource_group" "tfstate" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "devopss3pstorageaccount"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

resource "azurerm_container_group" "example" {
  name                = "example-container-group"
  location            = azurerm_resource_group.tfstate.location
  resource_group_name = azurerm_resource_group.tfstate.name
  os_type             = "Linux"

  container {
    name   = "nexus-repo"
    image  = "nitin333/nexus-repo"
    cpu    = "1.0"
    memory = "2.0"
    ports {
      port     = 8081
      protocol = "TCP"
    }
  }

  ip_address_type = "public"
  dns_name_label  = "example-nexus-container"
}