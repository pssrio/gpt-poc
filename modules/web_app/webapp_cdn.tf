resource "azurerm_cdn_profile" "cdn_profile" {
  name                = var.az_cdn_profile_name
  location            = var.az_location
  resource_group_name = var.az_resource_group_name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = "nimblyzgpt"
  profile_name        = azurerm_cdn_profile.cdn_profile.name
  location            = var.az_location
  resource_group_name = var.az_resource_group_name
  origin_host_header  = azurerm_storage_account.sa.primary_web_host

  origin {
    name      = "origin"
    host_name = azurerm_storage_account.sa.primary_web_host
  }
}
