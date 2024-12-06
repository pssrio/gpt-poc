# Create SP for creation of Azure resources in selected subscription.

resource "azuread_application" "resource_creation" {
  display_name = var.azad_resource_creation_sp_name
}

resource "azuread_service_principal" "resource_creation" {
  client_id = azuread_application.resource_creation.client_id
}

resource "azuread_service_principal_password" "resource_creation" {
  service_principal_id = azuread_service_principal.resource_creation.object_id
}

# service_principal Permissions on Azure Subcriptions 

resource "azurerm_role_assignment" "resource_creation" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.resource_creation.object_id
}
