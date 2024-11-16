terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.2.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-backend"
    storage_account_name = "backendstorageqaw"
    container_name       = "tfstatefile"
    key                  = "Dev.tfstate"
  }
}
