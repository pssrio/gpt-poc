variable "az_resource_group_name" {
  description = "The name of the Azure resource group."
  type        = string
}
variable "az_location" {
  type    = string
  description = "Location of the resource"
}
variable "az_container_registry_name" {
  type    = string
  description = "Name of the Azure Container Registy"
}
variable "chatservice_name" {
  type    = string
  description = "Name of the chatservice conatainer app "
}
variable "api_mgmt_url" {
  type    = string
  description = "API management URL"
}
variable "chatservice_api_key" {
  type    = string
  description = "Chat Service API KEY VALUE "

