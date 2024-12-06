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


# Create Azure DevOps Project Service Connection to Container Registry

resource "azuredevops_serviceendpoint_azurecr" "serviceendpoint_azurecr" {
  project_id                = azuredevops_project.project.id
  service_endpoint_name     = "Nimbly-AzureCR"
  resource_group            = var.az_resource_group_name
  azurecr_spn_tenantid      = data.azurerm_client_config.current.tenant_id
  azurecr_name              = var.az_container_registry_name
  azurecr_subscription_id   = data.azurerm_client_config.current.subscription_id
  azurecr_subscription_name = data.azurerm_subscription.current.display_name
}

# Authorize Pipelines to Azure Container Registry

resource "azuredevops_pipeline_authorization" "azurecr_auth" {
  project_id  = azuredevops_project.project.id
  resource_id = azuredevops_serviceendpoint_azurecr.serviceendpoint_azurecr.id
  type        = "endpoint"
}


