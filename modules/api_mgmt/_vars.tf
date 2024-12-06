variable "az_resource_group_name" {
  description = "The name of the Azure resource group."
  type        = string
}

variable "az_location" {
  type        = string
  description = "Location of the resource"
}

variable "az_api_management_name" {
  description = "The name of the Azure API Management."
  type        = string
}

variable "az_container_app_name" {
  type        = string
  description = "Name of the chatservice conatainer app "
}

variable "az_container_app_url" {
  type        = string
  description = "The FQDN of the ingress of Azure Container App"
}

variable "az_container_app_resource_id" {
  type        = string
  description = "The ID of the Azure Container App"
}

# variable "api_service_url" {
#   type        = string
#   description = "Absolute URL(HTTPS EndPoint) of the backend service implementing this API"
# }

variable "az_windows_function_app_name" {
  description = "Name of the function app"
  type        = string
}

variable "az_windows_function_app_resource_id" {
  description = "Resource ID of Azure Function App"
  type        = string
}

variable "az_function_app_url" {
  type        = string
  description = "Default hostname/URL of Azure function app"
}

# Auth Server Variables

variable "publisher_name" {
  type        = string
  description = "The name of the owner of the service"
}

variable "publisher_email" {
  type        = string
  description = "The email address of the owner of the service"
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

/*
variable "authorizer" {
  type = list(object({
    authorization-endpoint       = string
    auth-client-id                    = string
    auth-client-secret                = string
    auth-client-registration-endpoint = string
    auth-token-endpoint               = string
  }))
  default = []
}
*/

variable "chatservice-routes" {
  type = list(object({
    name          = string
    url_template  = string
    path          = string
    method        = string
    api_name      = string
    target        = string
  }))
}

variable "historyservice-routes" {
  type = list(object({
    name          = string
    url_template  = string
    path          = string
    method        = string
    api_name      = string
    target        = string
  }))
}

