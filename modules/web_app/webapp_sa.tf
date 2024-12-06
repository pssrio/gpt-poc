resource "azurerm_storage_account" "sa" {
  name                     = var.az_storage_account_name
  resource_group_name      = var.az_resource_group_name
  location                 = var.az_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}