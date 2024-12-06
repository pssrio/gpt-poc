resource "azurerm_resource_group" "rg" {
  name     = local.az_resource_group_name
  location = var.az_location
}

module "web_app" {
  source                  = "./modules/web_app"
  az_resource_group_name  = azurerm_resource_group.rg.name
  az_location             = azurerm_resource_group.rg.location
  az_storage_account_name = local.az_storage_account_name
  az_cdn_profile_name     = local.az_cdn_profile_name
}

module "ado_project_webapp" {
  source                         = "./modules/ado_project_webapp"
  ado_webapp_project_name        = local.ado_webapp_project_name
  ado-github-pat                 = var.ado-github-pat
  ado-org-service-url            = var.ado-org-service-url
  ado-azudevops-pat              = var.ado-azudevops-pat
  azad_resource_creation_sp_name = local.azad_resource_creation_sp_name
  az_storage_account_name        = local.az_storage_account_name
  ado_github_repo_webapp         = var.ado_github_repo_webapp
  ado_pipeline_yaml_path_webapp  = var.ado_pipeline_yaml_path_webapp
  ado_pipeline_name_webapp       = local.ado_pipeline_name_webapp
}

module "chatservice_app" {
  source                     = "./modules/chatservice_app"
  az_resource_group_name     = azurerm_resource_group.rg.name
  az_location                = azurerm_resource_group.rg.location
  az_container_registry_name = local.az_container_registry_name
  chatservice_name           = local.chatservice_name
  api_mgmt_url               = module.api_mgmt.api_mgmt_url
}

module "ado_project_chatservice" {
  source                             = "./modules/ado_project_chatservice"
  az_resource_group_name             = azurerm_resource_group.rg.name
  ado_chatservice_project_name       = local.ado_chatservice_project_name
  ado-github-pat                     = var.ado-github-pat
  ado-org-service-url                = var.ado-org-service-url
  ado-azudevops-pat                  = var.ado-azudevops-pat
  ado_github_repo_chatservice        = var.ado_github_repo_chatservice
  ado_pipeline_yaml_path_chatservice = var.ado_pipeline_yaml_path_chatservice
  az_container_registry_name         = local.az_container_registry_name
  az_container_registry_login_server = module.chatservice_app.az_container_registry_login_server
  ado_pipeline_name_chatservice      = local.ado_pipeline_name_chatservice
}

module "api_mgmt" {
  source = "./modules/api_mgmt"

  az_resource_group_name              = azurerm_resource_group.rg.name
  az_location                         = azurerm_resource_group.rg.location
  az_api_management_name              = local.az_api_management_name
  publisher_name                      = var.publisher_name
  publisher_email                     = var.publisher_email
  az_container_app_name               = module.chatservice_app.az_container_app_name
  az_container_app_url                = module.chatservice_app.az_container_app_url
  az_container_app_resource_id        = module.chatservice_app.az_container_app_resource_id
  az_windows_function_app_name        = module.historyservice_app.az_windows_function_app_name
  az_windows_function_app_resource_id = module.historyservice_app.az_windows_function_app_resource_id
  az_function_app_url                 = module.historyservice_app.az_function_app_url
  authorization-server-name           = var.authorization-server-name
  authorization-endpoint              = var.authorization-endpoint
  auth-client-id                           = var.auth-client-id
  auth-client-secret                       = var.auth-client-secret
  auth-client-registration-endpoint        = var.auth-client-registration-endpoint
  auth-token-endpoint                      = var.auth-token-endpoint


  chatservice-routes = [
    {
      name         = "chatservice"
      url_template = "/*"
      path         = "/"
      method       = "GET"
      api_name     = module.api_mgmt.chatservice_api_name
      target       = module.chatservice_app.az_container_app_url
    },
    {
      name         = "chatservice"
      url_template = "/*"
      path         = "/"
      method       = "POST"
      api_name     = module.api_mgmt.chatservice_api_name
      target       = module.chatservice_app.az_container_app_url
    },
    {
      name         = "chatservice"
      url_template = "/*"
      path         = "/"
      method       = "HEAD"
      api_name     = module.api_mgmt.chatservice_api_name
      target       = module.chatservice_app.az_container_app_url
    },
    {
      name         = "chatservice"
      url_template = "/*"
      path         = "/"
      method       = "OPTIONS"
      api_name     = module.api_mgmt.chatservice_api_name
      target       = module.chatservice_app.az_container_app_url
    }
  ]

  historyservice-routes = [
    {
      name         = "historyservice"
      url_template = "/list"
      path         = "list"
      method       = "GET"
      api_name     = module.api_mgmt.historyservice_api_name
      target       = module.historyservice_app.az_function_app_url
    },
    {
      name         = "historyservice"
      url_template = "/new"
      path         = "new"
      method       = "POST"
      api_name     = module.api_mgmt.historyservice_api_name
      target       = module.historyservice_app.az_function_app_url
    }
  ]
}


module "historyservice_app" {
  source                        = "./modules/historyservice_app"
  az_resource_group_name        = azurerm_resource_group.rg.name
  az_location                   = azurerm_resource_group.rg.location
  az_func_storage_account_name  = local.az_func_storage_account_name
  az_service_plan_name          = local.az_service_plan_name
  az_cosmosdb_account_name      = local.az_cosmosdb_account_name
  az_cosmosdb_sql_database_name = local.az_cosmosdb_sql_database_name
  az_windows_function_app_name  = local.az_windows_function_app_name
}