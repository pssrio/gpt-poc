terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.7"

    }
  }
}

provider azurerm {
  features {}
}
