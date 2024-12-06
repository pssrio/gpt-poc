resource "azuredevops_project" "project" {
  name               = var.ado_chatservice_project_name
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"

  features = {
    "testplans"    = "disabled"
    "artifacts"    = "disabled"
    "boards"       = "disabled"
    "repositories" = "disabled"
    "pipelines"    = "enabled"
  }
}

