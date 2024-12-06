resource "azurerm_api_management_api" "chatservice_api" {
  subscription_required = false
  revision              = "1"
  resource_group_name   = var.az_resource_group_name
  api_management_name   = azurerm_api_management.apim.name
  name                  = var.az_container_app_name
  display_name          = var.az_container_app_name
  protocols             = ["https"]
  service_url           = var.az_container_app_url
 
  oauth2_authorization {
   authorization_server_name = var.authorization-endpoint == "" ? null : azurerm_api_management_authorization_server.auth_server[0].name
  }
}

resource "azurerm_api_management_api_operation" "chat_services_operations" {
  for_each = { for route in var.chatservice-routes : "${route.name}-${route.method}" => route } //{ for route in var.routes: route.name => route }

  url_template        = each.value.url_template
  resource_group_name = var.az_resource_group_name
  operation_id        = "${each.value.name}-${each.value.method}"
  method              = each.value.method
  display_name        = "${each.value.name}-${each.value.method}"
  api_name            = each.value.api_name
  api_management_name = azurerm_api_management.apim.name
}

// Adding APIM-API-Backend manually

resource "azurerm_api_management_backend" "containerapp_chatservice" {
  depends_on          = [ var.az_container_app_resource_id ]
  url                 = var.az_container_app_url
  resource_id         = var.az_container_app_resource_id
  resource_group_name = var.az_resource_group_name
  protocol            = "http"
  name                = var.az_container_app_name
  api_management_name = azurerm_api_management.apim.name
}

resource "azurerm_api_management_api_policy" "chatservice_api_policy" {
  api_name            = azurerm_api_management_api.chatservice_api.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.az_resource_group_name

  xml_content = <<XML
<policies>
    <inbound>
        <base />
        <set-backend-service backend-id="${azurerm_api_management_backend.containerapp_chatservice.name}" />
        <validate-jwt header-name="Authorization" failed-validation-httpcode="401" require-scheme="bearer">
            <openid-config url="https://zgpt.au.auth0.com/.well-known/openid-configuration" />
            <audiences>
                <audience>zgpt-auth-api</audience>
            </audiences>
        </validate-jwt>
        <cors allow-credentials="false">
            <allowed-origins>
                <origin>*</origin>
            </allowed-origins>
            <allowed-methods>
                <method>GET</method>
                <method>POST</method>
                <method>HEAD</method>
                <method>OPTIONS</method>
            </allowed-methods>
            <allowed-headers>
                <header>*</header>
            </allowed-headers>
        </cors>
        <set-header name="userid" exists-action="append">
            <value>@{                string token = context.Request.Headers.GetValueOrDefault("Authorization").Replace("bearer ","");                Jwt jwt;                if(token.TryParseJwt(out jwt)){                    foreach(var claim in jwt.Claims){                        if(claim.Key == "sub"){                            return string.Join("",claim.Value);                        }                    }                }                return "Error";            }</value>
        </set-header>
      </inbound>
</policies>
XML
}