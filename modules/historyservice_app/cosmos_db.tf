resource "azurerm_cosmosdb_account" "zgpt_dba" {
  resource_group_name = var.az_resource_group_name
  offer_type          = "Standard"
  name                = var.az_cosmosdb_account_name
  location            = var.az_location

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.az_location
    failover_priority = 0
  }

  tags = {
    defaultExperience = "Core (SQL)"
  }
}

resource "azurerm_cosmosdb_sql_database" "zgpt_db" {
  resource_group_name = var.az_resource_group_name
  name                = var.az_cosmosdb_sql_database_name
  account_name        = azurerm_cosmosdb_account.zgpt_dba.name
}


resource "azurerm_cosmosdb_sql_role_definition" "cosmos_db_reader" {
  type                = "CustomRole"
  resource_group_name = var.az_resource_group_name
  name                = "Cosmos DB Data Reader"
  account_name        = azurerm_cosmosdb_account.zgpt_dba.name
  assignable_scopes   = [azurerm_cosmosdb_account.zgpt_dba.id]

  permissions {
    data_actions = [
      "Microsoft.DocumentDB/databaseAccounts/readMetadata",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeQuery",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/readChangeFeed",
    ]
  }
}

resource "azurerm_cosmosdb_sql_role_definition" "cosmos_db_contributor" {
  type                = "CustomRole"
  resource_group_name = var.az_resource_group_name
  name                = "Cosmos DB Data Contributor"
  account_name        = azurerm_cosmosdb_account.zgpt_dba.name
  assignable_scopes   = [azurerm_cosmosdb_account.zgpt_dba.id]

  // terraform import azurerm_cosmosdb_sql_role_definition.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.DocumentDB/databaseAccounts/account1/sqlRoleDefinitions/28b3c337-f436-482b-a167-c2618dc52033

  permissions {
    data_actions = [
      "Microsoft.DocumentDB/databaseAccounts/readMetadata",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*",
    ]
  }
}

resource "azurerm_cosmosdb_sql_container" "db_container" {
  name                  = "thread"
  resource_group_name   = var.az_resource_group_name
  account_name          = azurerm_cosmosdb_account.zgpt_dba.name
  database_name         = azurerm_cosmosdb_sql_database.zgpt_db.name
  partition_key_path    = "/userId"
  partition_key_version = 2

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/\"_etag\"/?"
    }
  }
}