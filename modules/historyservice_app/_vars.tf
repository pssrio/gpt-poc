variable "az_resource_group_name" {
  description = "The name of the Azure resource group."
  type        = string
}

variable "az_location" {
  description = "The Azure region to deploy the resources."
  type        = string
}

variable "az_func_storage_account_name" {
  description = "The name of the Azure Storage Account."
  type        = string
}

variable "az_cosmosdb_account_name" {
  description = "Name of the Cosmos Database Account"
  type        = string
}


variable "az_cosmosdb_sql_database_name" {                     
  description = "Name of Cosmos SQL Database Name"
  type        = string
}


variable "az_service_plan_name" {
  description = "Name of App service plan for function app"
  type        = string
}

variable "az_windows_function_app_name" {
  description = "Name of the function app"
  type        = string
}

