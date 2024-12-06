
# Create a Key Vault
resource "azurerm_key_vault" "setup" {
  name                = var.az_key_vault_name
  location            = var.az_location
  resource_group_name = var.az_resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"
  // enable_rbac_authorization = true
}
# Set access policies
# Grant yourself full access (probably could be restricted to just secret_permissions)
resource "azurerm_key_vault_access_policy" "you" {
  key_vault_id = azurerm_key_vault.setup.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  key_permissions = [
  "Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]

  secret_permissions = [
  "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]

  certificate_permissions = [
  "Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge"]
}

# Grant the pipeline SP access to [Get,List] secrets from the KV
resource "azurerm_key_vault_access_policy" "pipeline" {
  key_vault_id = azurerm_key_vault.setup.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azuread_service_principal.service_connection.object_id

  secret_permissions = [
  "Get", "List"]
}

# Populate with secrets to be used by the pipeline
resource "azurerm_key_vault_secret" "pipeline" {
  depends_on = [
    azurerm_key_vault_access_policy.you
  ]
  for_each     = var.pipeline_variables
  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.setup.id
}

resource "azurerm_key_vault_secret" "auth" {
  depends_on = [
    azurerm_key_vault_access_policy.you
  ]
  for_each     = var.auth_variables
  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.setup.id
}
