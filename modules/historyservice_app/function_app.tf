resource "azurerm_service_plan" "asp_zgpt" {
  sku_name            = "Y1"
  resource_group_name = var.az_resource_group_name
  os_type             = "Windows"
  name                = var.az_service_plan_name
  location            = var.az_location
}

resource "azurerm_storage_account" "func-srt-act" {
  name                     = var.az_func_storage_account_name
  resource_group_name      = var.az_resource_group_name
  location                 = var.az_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_windows_function_app" "zgpt-history" {
  service_plan_id             = azurerm_service_plan.asp_zgpt.id
  resource_group_name         = var.az_resource_group_name
  name                        = var.az_windows_function_app_name
  storage_account_name        = azurerm_storage_account.func-srt-act.name
  storage_account_access_key  = azurerm_storage_account.func-srt-act.primary_access_key
  location                    = var.az_location
  client_certificate_mode     = "Required"
  builtin_logging_enabled     = false

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE      = "1"
    CosmosDBKey                   = azurerm_cosmosdb_account.zgpt_dba.primary_key
    CosmosDBEndpoint              = azurerm_cosmosdb_account.zgpt_dba.endpoint
    AzureWebJobsSecretStorageType = "files"
    AzureWebJobsFeatureFlags      = "EnableWorkerIndexing"
    FUNCTIONS_WORKER_RUNTIME      = "node"
  }

  site_config {
    ftps_state                             = "FtpsOnly"
//  application_insights_connection_string = 
//  api_management_api_id                  = 
    cors {
      allowed_origins = [
        "https://portal.azure.com",
      ]
    }
    application_stack {
      node_version = "~18"
    }
  }
}
