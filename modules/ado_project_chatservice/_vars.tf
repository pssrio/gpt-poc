variable "az_resource_group_name" {
  description = "The name of the Azure resource group."
  type        = string
}


variable "ado_chatservice_project_name" {
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

variable "ado_github_repo_chatservice" {
  type        = string
  description = "Name of the repository in the format <GitHub Org>/<RepoName>"
}

variable "ado_pipeline_yaml_path_chatservice" {
  type        = string
  description = "Path to the yaml for the chatservice pipeline"
}

variable "ado_pipeline_name_chatservice" {
  type        = string
  description = "Name ofthe the Webapp pipeline"
}

variable "az_container_registry_name" {
  type    = string
  description = "Name of the Azure Container Registy"
}

variable "az_container_registry_login_server" {
  type    = string
  description = "Login server of the Azure Container Registy"
}


