variable "az_location" {
  description = "The Azure region to deploy the resources."
  type        = string
}

variable "az_storage_account_name" {
  description = "The name of the Azure Storage Account."
  type        = string
}

variable "az_cdn_profile_name" {
  description = "The name of the Azure CDN profile."
  type        = string
}

variable "az_resource_group_name" {
  description = "The name of the Azure resource group."
  type        = string
}
