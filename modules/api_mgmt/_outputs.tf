output "api_mgmt_url" {
  value = azurerm_api_management.apim.gateway_url
}

output "chatservice_api_name" {
  value = azurerm_api_management_api.chatservice_api.name
}


output "historyservice_api_name" {
  value = azurerm_api_management_api.historyservice_api.name
}
