
/*
output "azurerm_cosmosdb_account_resourse_id" {
  value = azurerm_cosmosdb_account.zgpt_dba.id
}
*/

output "az_function_app_url" {
  value = "https://${azurerm_windows_function_app.zgpt-history.default_hostname}/api"
}

output "az_windows_function_app_name" {
  value = azurerm_windows_function_app.zgpt-history.name
}

output "az_windows_function_app_resource_id" {
  value = "https://management.azure.com${azurerm_windows_function_app.zgpt-history.id}"
}