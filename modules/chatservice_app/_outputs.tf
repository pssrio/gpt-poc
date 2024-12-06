output az_container_registry_name {
  value       = azurerm_container_registry.cr.name
}

output az_container_registry_login_server {
  value       = azurerm_container_registry.cr.login_server
}

output "az_container_app_url" {
  value = "https://${azurerm_container_app.chatservice.ingress[0].fqdn}"
}

output "az_container_app_name" {
  value = azurerm_container_app.chatservice.name
}

output "az_container_app_resource_id" {
  value = "https://management.azure.com${azurerm_container_app.chatservice.id}"
}
