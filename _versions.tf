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
    random = {
      source  = "hashicorp/random"
      version = "~>3.5"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.4"
    }
  }
  backend "azurerm" {
    resource_group_name  = "nimbly-tfstate-rg"
    storage_account_name = "nimblytfstate"
    container_name       = "zgpt-tf-app"
    key                  = "terraform.tfstate"
  }  
}

# Initialize the Azure DevOps provider
provider "azuredevops" {
  org_service_url       = var.ado-org-service-url
  personal_access_token = var.ado-azudevops-pat
  # Authentication through PAT defined with AZDO_PERSONAL_ACCESS_TOKEN 
}

provider "azurerm" {
  features {}
}

provider "random" {

}

provider "azuread" {
}

