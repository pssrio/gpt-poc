output "web_app_url" {
  depends_on = [var.az_resource_group_name]
  value = azurerm_cdn_endpoint.cdn_endpoint.fqdn
}


output "az_storage_account_name" {
 
  value = azurerm_storage_account.sa.name
}