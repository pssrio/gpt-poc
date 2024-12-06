resource "azurerm_api_management_api" "historyservice_api" {
  subscription_required = false
  revision              = "1"
  resource_group_name   = var.az_resource_group_name
  api_management_name   = azurerm_api_management.apim.name
  name                  = var.az_windows_function_app_name
  display_name          = var.az_windows_function_app_name
  protocols             = ["https"]
  path                  = "history"
  service_url           = var.az_function_app_url
 
  oauth2_authorization {
   authorization_server_name = var.authorization-endpoint == "" ? null : azurerm_api_management_authorization_server.auth_server[0].name
  }
  
}

resource "azurerm_api_management_api_operation" "history_services_operations" {

  for_each = { for route in var.historyservice-routes : "${route.name}-${route.method}" => route } //{ for route in var.routes: route.name => route }

  url_template        = each.value.url_template
  resource_group_name = var.az_resource_group_name
  operation_id        = "${each.value.name}-${each.value.method}"
  method              = each.value.method
  display_name        = "${each.value.path}"
  api_name            = each.value.api_name
  api_management_name = azurerm_api_management.apim.name
}

resource "azurerm_api_management_backend" "func_app_backend" {
  url                 = var.az_function_app_url
  resource_id         = var.az_windows_function_app_resource_id
  resource_group_name = var.az_resource_group_name
  protocol            = "http"
  name                = var.az_windows_function_app_name
  api_management_name = azurerm_api_management.apim.name

  #  credentials {
  #   header = {
  #     x-functions-key = "{{${var.az_windows_function_app_name}-key}}" //"${data.azurerm_function_app_host_keys.func_app.default_function_key}"
  #   }
  # }
}

resource "azurerm_api_management_api_policy" "historyservice_api_policy" {
  api_name            = azurerm_api_management_api.historyservice_api.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.az_resource_group_name

  xml_content = <<XML
<policies>
    <inbound>
        <base />     
        <set-backend-service backend-id="${azurerm_api_management_backend.func_app_backend.name}" />
        <cors allow-credentials="false">
            <allowed-origins>
                <origin>*</origin>
            </allowed-origins>
            <allowed-methods>
                <method>GET</method>
                <method>POST</method>
                <method>HEAD</method>
            </allowed-methods>
            <allowed-headers>
                <header>*</header>
            </allowed-headers>
        </cors>
        <validate-jwt header-name="Authorization" failed-validation-httpcode="401">
            <openid-config url="https://zgpt.au.auth0.com/.well-known/openid-configuration" />
            <audiences>
                <audience>zgpt-auth-api</audience>
            </audiences>
        </validate-jwt>
        <set-query-parameter name="userid" exists-action="override">
            <value>@{                string token = context.Request.Headers.GetValueOrDefault("Authorization").Replace("bearer ","");                Jwt jwt;                if(token.TryParseJwt(out jwt)){                    foreach(var claim in jwt.Claims){                        if(claim.Key == "sub"){                            return string.Join("",claim.Value);                        }                    }                }                return "Error";            }</value>
        </set-query-parameter>
      </inbound>
</policies>
XML
}
