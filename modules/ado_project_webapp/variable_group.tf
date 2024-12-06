resource "azuredevops_variable_group" "vg-web" {
  project_id   = azuredevops_project.project.id
  name         = "zgpt-webservice"
  description  = "Variable group for pipelines"
  allow_access = true

  variable {
    name  = "Service-AzureRM"
    value = "Nimbly-AzureRM"
  }
  variable {
    name  = "storageaccount"
    value = var.az_storage_account_name
  }
}
