resource "azuredevops_variable_group" "vg-chat" {
  project_id   = azuredevops_project.project.id
  name         = "zgpt-chatservice"
  description  = "Variable group for chatservice pipelines"
  allow_access = true


  variable {
    name  = "docker-service-name"
    value = azuredevops_serviceendpoint_azurecr.serviceendpoint_azurecr.service_endpoint_name
  }

  variable {
    name  = "container-reg-name"
    value = var.az_container_registry_name
  }

  variable {
    name  = "container-reg-server"
    value = var.az_container_registry_login_server
  }
  variable {
    name  = "imageRepository"
    value = "nimblyconsultingzgptchatservice"
  }
  variable {
    name  = "dockerfilePath"
    value = "$(Build.SourcesDirectory)/Dockerfile"
  }
  variable {
    name  = "tag"
    value = "latest"
  }
  variable {
    name  = "docker-service-name"
    value = "Nimbly-AzureCR"
  }
}