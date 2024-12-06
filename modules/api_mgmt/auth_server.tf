resource "azurerm_api_management" "apim" {
  sku_name            = "Consumption_0"
  resource_group_name = var.az_resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  name                = var.az_api_management_name
  location            = var.az_location

  identity {
    # User assigned identities are not supported yet
    type = "SystemAssigned"
  }
}

resource "azurerm_api_management_authorization_server" "auth_server" {
  count                        = var.authorization-endpoint == "" ? 0 : 1
  name                         = var.authorization-server-name
  api_management_name          = azurerm_api_management.apim.name
  resource_group_name          = var.az_resource_group_name
  display_name                 = var.authorization-server-name
  authorization_endpoint       = var.authorization-endpoint
  client_id                    = var.auth-client-id
  client_secret                = var.auth-client-secret
  client_registration_endpoint = var.auth-client-registration-endpoint
  token_endpoint               = var.auth-token-endpoint

  authorization_methods = [
    "GET",
  ]

  bearer_token_sending_methods = [
    "authorizationHeader",
  ]

  client_authentication_method = [
    "Basic",
  ]

  grant_types = [
    "authorizationCode",
  ]
}