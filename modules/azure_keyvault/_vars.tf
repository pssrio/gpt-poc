variable "az_resource_group_name" {
  description = "The name of the Azure resource group."
  type        = string
}

variable "az_location" {
  type    = string
  description = "Location of the resource"
}

variable "az_key_vault_name" {
  description = "The name of the Azure KeyVault"
  type        = string
}

variable "pipeline_variables" {
    description = "Pipelines Variables will be stoted in Keyvault"
    type        = map
}

variable "auth_variables" {
    description = "Pipelines Variables will be stoted in Keyvault"
    type        = map
}

variable "azad_service_connection_sp_name" {
    description = "AZDO pipeline with Keyvault"
    type        = string
}
