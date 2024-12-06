resource "azuredevops_build_definition" "pipeline_chatservice" {

  depends_on = [azuredevops_pipeline_authorization.auth]
  project_id = azuredevops_project.project.id
  name       = var.ado_pipeline_name_chatservice

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type             = "GitHub"
    repo_id               = var.ado_github_repo_chatservice
    branch_name           = "main"
    yml_path              = var.ado_pipeline_yaml_path_chatservice
    service_connection_id = azuredevops_serviceendpoint_github.serviceendpoint_github.id
  }

}

