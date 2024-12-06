resource "azurerm_container_registry" "cr" {
  sku                 = "Standard"
  resource_group_name = var.az_resource_group_name
  name                = var.az_container_registry_name
  location            = var.az_location
  admin_enabled       = true
}

resource "azurerm_container_registry_scope_map" "repositories-pull" {
  resource_group_name     = var.az_resource_group_name
  name                    = "repositories-pull"
  description             = "Can pull any repository of the registry"
  container_registry_name = azurerm_container_registry.cr.name

  actions = [
    "repositories/*/content/read",
  ]
}

resource "azurerm_container_registry_scope_map" "repositories-admin" {
  resource_group_name     = var.az_resource_group_name
  name                    = "repositories-admin"
  description             = "Can perform all read, write and delete operations on the registry"
  container_registry_name = azurerm_container_registry.cr.name

  actions = [
    "repositories/*/metadata/read",
    "repositories/*/metadata/write",
    "repositories/*/content/read",
    "repositories/*/content/write",
    "repositories/*/content/delete",
  ]
}

resource "azurerm_container_registry_scope_map" "repositories-push" {
  resource_group_name     = var.az_resource_group_name
  name                    = "repositories-push"
  description             = "Can push to any repository of the registry"
  container_registry_name = azurerm_container_registry.cr.name

  actions = [
    "repositories/*/content/read",
    "repositories/*/content/write",
  ]
}
