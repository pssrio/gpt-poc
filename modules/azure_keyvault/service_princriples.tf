# Create SP for service connection in pipeline. Will be used to access KV

resource "azuread_application" "service_connection" {
  display_name = var.azad_service_connection_sp_name
}

resource "azuread_service_principal" "service_connection" {
  client_id = azuread_application.service_connection.client_id
}

resource "azuread_service_principal_password" "service_connection" {
  service_principal_id = azuread_service_principal.service_connection.object_id
}
