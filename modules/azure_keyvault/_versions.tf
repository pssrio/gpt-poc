terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.7"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.4"
    }
  }
}

provider "azurerm" {
  features {}
}
