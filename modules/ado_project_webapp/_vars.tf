variable "ado_webapp_project_name" {
  type        = string
  description = "Name of the Azure DevOps project"
}

variable "ado-github-pat" {
  description = "GitHub personal access token for Azure DevOps"
  type        = string
}

variable "ado-org-service-url" {
  type        = string
  description = "Org service url for Azure DevOps"
}

variable "ado-azudevops-pat" {
  type        = string
  description = "Personal authentication token for Azure DevOps Organization"
  sensitive   = true
}

variable "azad_resource_creation_sp_name" {
  type    = string
  description = "Azure AD resource creation Service Principle name"
}

variable "ado_github_repo_webapp" {
  type        = string
  description = "Name of the repository in the format <GitHub Org>/<RepoName>"
}

variable "ado_pipeline_yaml_path_webapp" {
  type        = string
  description = "Path to the yaml for the first pipeline"
}

variable "ado_pipeline_name_webapp" {
  type        = string
  description = "Name ofthe the Webapp pipeline"
}

variable "az_storage_account_name" {
  description = "The name of the Azure Storage Account."
  type        = string
}
