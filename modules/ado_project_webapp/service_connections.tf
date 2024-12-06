# Create Azure DevOps Project Service Connection to Github

resource "azuredevops_serviceendpoint_github" "serviceendpoint_github" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "terraform-nimbly"

  auth_personal {
    personal_access_token = var.ado-github-pat
  }
}

# Authorize Pipelines to Github

resource "azuredevops_pipeline_authorization" "auth" {
  project_id  = azuredevops_project.project.id
  resource_id = azuredevops_serviceendpoint_github.serviceendpoint_github.id
  type        = "endpoint"
}


# Create Azure DevOps Project Service Connection to AzureRM

resource "azuredevops_serviceendpoint_azurerm" "serviceendpoint_azurerm" {
  project_id                             = azuredevops_project.project.id
  service_endpoint_name                  = "Nimbly-AzureRM"
  description                            = "Managed by Terraform"
  service_endpoint_authentication_scheme = "ServicePrincipal"
  credentials {
    serviceprincipalid  = azuread_application.resource_creation.client_id
    serviceprincipalkey = azuread_service_principal_password.resource_creation.value
  }
  azurerm_spn_tenantid      = data.azurerm_client_config.current.tenant_id
  azurerm_subscription_id   = data.azurerm_client_config.current.subscription_id
  azurerm_subscription_name = data.azurerm_subscription.current.display_name
}

# Authorize Pipelines to AzureRM

resource "azuredevops_pipeline_authorization" "serviceendpoint_azurerm_auth" {
  project_id  = azuredevops_project.project.id
  resource_id = azuredevops_serviceendpoint_azurerm.serviceendpoint_azurerm.id
  type        = "endpoint"
}


