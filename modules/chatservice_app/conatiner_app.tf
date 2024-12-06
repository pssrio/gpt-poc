resource "azurerm_log_analytics_workspace" "logaw" {
  name                = "zgpt-log-analytics-workspace"
  location            = var.az_location
  resource_group_name = var.az_resource_group_name
}

resource "azurerm_container_app_environment" "managedenvironment" {
  resource_group_name        = var.az_resource_group_name
  name                       = "managedEnvironment-zgptdemo"
  location                   = var.az_location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logaw.id
}

resource "azurerm_container_app" "chatservice" {
  revision_mode                = "Single"
  resource_group_name          = var.az_resource_group_name
  name                         = var.chatservice_name
  container_app_environment_id = azurerm_container_app_environment.managedenvironment.id

  ingress {
    target_port      = 8081
    external_enabled = true
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  registry {
    username             = azurerm_container_registry.cr.name
    server               = azurerm_container_registry.cr.login_server
    password_secret_name = azurerm_container_registry.cr.admin_username
  }
  secret {
    value = azurerm_container_registry.cr.admin_password
    name  = azurerm_container_registry.cr.admin_username
  }
  template {
    max_replicas = 4
    container {
      name   = var.chatservice_name
      memory = "0.5Gi"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
  //  image = "${azurerm_container_registry.cr.login_server}/nimblyconsultingzgptchatservice:latest"
      cpu   = 0.25
      env {
        value = "8081"
        name  = "PORT"
      }
      env {
        value = "zgpt-chat-service"
        name  = "LOGGER_NAME"
      }
      env {
        value = "debug"
        name  = "LOG_LEVEL"
      }
      env {
        value = "zgpt"
        name  = "SERVICE_DOMAIN"
      }
      env {
        value = "chat-service"
        name  = "SERVICE_NAME"
      }
      env {
        value = "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"
        name  = "API_KEY"
      }

      env {
        value = var.api_mgmt_url
        name  = "HISTORY_SERVICE"
      }
    }
  }
}
