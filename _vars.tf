variable "prefix" {
  type        = string
  description = "Naming prefix for resources"
  default     = "zgptvtwo"
}
resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}

variable "az_location" {
  description = "The Azure region to deploy the resources."
  type        = string
  default     = "Australia East"
}

variable "ado-github-pat" {
  type        = string
  description = "Personal authentication token for GitHub repo"
  sensitive   = true
}

variable "ado-azudevops-pat" {
  type        = string
  description = "Personal authentication token for Azure DevOps Organization"
  sensitive   = true
}
variable "ado-org-service-url" {
  type        = string
  description = "Org service url for Azure DevOps"
}

variable "ado_github_repo_webapp" {
  type        = string
  description = "Name of the repository in the format <GitHub Org>/<RepoName>"
  default     = "nimbly-consulting/zgpt-web-app"
}

variable "ado_pipeline_yaml_path_webapp" {
  type        = string
  description = "Path to the yaml for the first pipeline"
  default     = "azure-pipelines-tf.yml"
}

variable "ado_github_repo_chatservice" {
  type        = string
  description = "Name of the repository in the format <GitHub Org>/<RepoName>"
  default     = "nimbly-consulting/zgpt-chat-service"
}
variable "ado_pipeline_yaml_path_chatservice" {
  type        = string
  description = "Path to the yaml for the first pipeline"
  default     = "azure-pipelines-tf.yml"
}

# API Management variables
variable "publisher_name" {
  type        = string
  description = "The name of the owner of the service"
  default     = "Nimbly"
}

variable "publisher_email" {
  type        = string
  description = "The email address of the owner of the service"
  default     = "nimbly@nimbly.consulting"
}


variable "authorization-server-name" {
  type        = string
  description = "Name of the authorization server"
}

variable "authorization-endpoint" {
  type        = string
  description = "The OAUTH Authorization Endpoint URL"
}

variable "auth-client-id" {
  type        = string
  description = "The Client/App ID registered with this Authorization Server"
}

variable "auth-client-secret" {
  type        = string
  description = "The Client/App Secret registered with this Authorization Server"
  sensitive   = true
}

variable "auth-client-registration-endpoint" {
  type        = string
  description = "The URL of page where Client/App Registration is performed for this Authorization Server."
}

variable "auth-token-endpoint" {
  type        = string
  description = "The OAUTH Token Endpoint URL"
}
variable "chatservice_api_key" {
  type    = string
  description = "Chat Service API KEY VALUE "
  
# Local variables

locals {
  az_resource_group_name       = "${var.prefix}${random_integer.suffix.result}"
  az_storage_account_name      = "webappsta${random_integer.suffix.result}"
  az_func_storage_account_name = "functionappsta${random_integer.suffix.result}"

  # webapp variables
  az_cdn_profile_name            = "cdn${random_integer.suffix.result}"
  ado_webapp_project_name        = "${var.prefix}-webapp-${random_integer.suffix.result}"
  ado_pipeline_name_webapp       = "${var.prefix}-pipeline-webapp"
  azad_resource_creation_sp_name = "${var.prefix}-resource-creation-${random_integer.suffix.result}"

  #chat service variables
  chatservice_name              = "${var.prefix}chatservice"
  ado_chatservice_project_name  = "${var.prefix}-chatservice-${random_integer.suffix.result}"
  ado_pipeline_name_chatservice = "${var.prefix}-pipeline-chatservice"
  az_container_registry_name    = "${var.prefix}cr${random_integer.suffix.result}"

  # # KeyVault Variables:
  # az_key_vault_name = "${var.prefix}kv${random_integer.suffix.result}"

  # API Management
  az_api_management_name          = "${var.prefix}apim${random_integer.suffix.result}"
  azad_service_connection_sp_name = "${var.prefix}-service-connection-${random_integer.suffix.result}"
 
  #history service variables
  az_service_plan_name          = "${var.prefix}asp${random_integer.suffix.result}"
  az_cosmosdb_account_name      = "${var.prefix}act${random_integer.suffix.result}"
  az_cosmosdb_sql_database_name = "${var.prefix}cosmosdb${random_integer.suffix.result}"
  az_windows_function_app_name  = "${var.prefix}functionapp"

}