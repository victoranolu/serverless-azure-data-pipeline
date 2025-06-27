resource "azurerm_resource_group" "terraform-rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags = {
    "enviroment" = "development"
  }
  managed_by = "devops-terraform"

  timeouts {
    create = "20m"
    delete = "1h"
  }
}

resource "azurerm_data_factory" "data_factory" {
  name                = var.data_factory_name
  location            = azurerm_resource_group.terraform-rg.location
  resource_group_name = azurerm_resource_group.terraform-rg.name
}

resource "azurerm_data_factory_pipeline" "data_factory_pipeline" {
  name            = var.data_factory_pipeline
  data_factory_id = azurerm_data_factory.data_factory.id
}

resource "azurerm_storage_account" "dev_store" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.terraform-rg.name
  location                 = azurerm_resource_group.terraform-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_data_factory_trigger_blob_event" "blob_event" {
  name                  = var.blob_event
  data_factory_id       = azurerm_data_factory.data_factory.id
  storage_account_id    = azurerm_storage_account.dev_store.id
  events                = ["Microsoft.Storage.BlobCreated", "Microsoft.Storage.BlobDeleted"]
  blob_path_ends_with   = ".json"
  blob_path_begins_with = ".json"
  ignore_empty_blobs    = true
  activated             = true

  annotations = ["test1", "test2", "test3"]
  description = "blob event triggers"

  pipeline {
    name = azurerm_data_factory_pipeline.data_factory_pipeline.name
    parameters = {
      Env = "Development"
    }
  }
}

resource "azurerm_eventgrid_system_topic" "event_grid" {
  name                   = var.event_grid
  resource_group_name    = azurerm_resource_group.terraform-rg.name
  location               = azurerm_resource_group.terraform-rg.location
  source_arm_resource_id = azurerm_storage_account.dev_store.id
  topic_type             = "Microsoft.Storage.StorageAccounts"
}

resource "azurerm_service_plan" "service_plan" {
  name                = var.service_plan
  resource_group_name = azurerm_resource_group.terraform-rg.name
  location            = azurerm_resource_group.terraform-rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_function_app" "function_app" {
  name                = var.function_app
  resource_group_name = azurerm_resource_group.terraform-rg.name
  location            = azurerm_resource_group.terraform-rg.location

  storage_account_name       = azurerm_storage_account.dev_store.name
  storage_account_access_key = azurerm_storage_account.dev_store.primary_access_key
  service_plan_id            = azurerm_service_plan.service_plan.id

  site_config {}
}

resource "azurerm_storage_data_lake_gen2_filesystem" "data_lake" {
  name               = var.data_lake
  storage_account_id = azurerm_storage_account.dev_store.id
}

resource "azurerm_synapse_workspace" "data_synapse" {
  name                                 = var.data_synapse
  resource_group_name                  = azurerm_resource_group.terraform-rg.name
  location                             = azurerm_resource_group.terraform-rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.data_lake.id
  sql_administrator_login              = var.data_synapse_admin
  sql_administrator_login_password     = var.data_synapse_password

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Env = "development"
  }
}

resource "azurerm_stream_analytics_job" "data_stream" {
  name                                     = var.data_stream
  resource_group_name                      = azurerm_resource_group.terraform-rg.name
  location                                 = azurerm_resource_group.terraform-rg.location
  compatibility_level                      = "1.2"
  data_locale                              = "en-ZA"
  events_late_arrival_max_delay_in_seconds = 60
  events_out_of_order_max_delay_in_seconds = 50
  events_out_of_order_policy               = "Adjust"
  output_error_policy                      = "Drop"
  streaming_units                          = 3
  sku_name                                 = "StandardV2"

  tags = {
    environment = "development"
  }

  transformation_query = <<QUERY
    SELECT *
    INTO [YourOutputAlias]
    FROM [YourInputAlias]
QUERY
}