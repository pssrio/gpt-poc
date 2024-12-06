terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0.1"
    }
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

provider "azuredevops" {
  org_service_url       = var.ado-org-service-url
  personal_access_token = var.ado-azudevops-pat
  # Authentication through PAT defined with AZDO_PERSONAL_ACCESS_TOKEN 
}