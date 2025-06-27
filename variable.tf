variable "client_id" {
  type        = string
  description = "Azure Service Principal Client ID"

  validation {
    condition     = can(regex("^[-0-9a-fA-F]{36}$", var.client_id))
    error_message = "client_id must be a valid UUID (36 hex characters with dashes)."
  }
}

variable "client_secret" {
  type        = string
  description = "Azure Service Principal Client Secret"

  validation {
    condition     = length(var.client_secret) >= 16
    error_message = "client_secret must be at least 16 characters long."
  }
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"

  validation {
    condition     = can(regex("^[-0-9a-fA-F]{36}$", var.subscription_id))
    error_message = "subscription_id must be a valid UUID."
  }
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"

  validation {
    condition     = can(regex("^[-0-9a-fA-F]{36}$", var.tenant_id))
    error_message = "tenant_id must be a valid UUID."
  }
}

variable "resource_group_name" {
  type = string
  description = "Name of the resource group"

  validation {
    condition = can(regex("^[a-zA-Z][a-zA-Z0-9._-]*$", var.resource_group_name))
    error_message = "Azure resource group name name must be a valid string type starting with a letter and containing only letters, numbers, dots, underscores, and hyphens."
  }
}

variable "resource_group_location" {
  type        = string
  description = "Location for the resource group"
  
  validation {
    condition = contains([
      "eastus",
      "westeurope", 
      "southafricanorth",
      "uksouth",
      "centralus"
    ], var.resource_group_location)
    error_message = "resource_group_location must be one of: eastus, westeurope, southafricanorth, uksouth, centralus."
  }
}

variable "data_factory_name" {
  type = string
  description = "Name of the data factory"

  validation {
    condition = can(regex("^[a-zA-Z][a-zA-Z0-9._-]*$", var.data_factory_name))
    error_message = "data factory name must be a valid string type starting with a letter and containing only letters, numbers, dots, underscores, and hyphens."
  }
}

variable "data_factory_pipeline" {
  type = string
  description = "Name of the data factory pipeline"

  validation {
    condition = can(regex("^[a-zA-Z][a-zA-Z0-9._-]*$", var.data_factory_pipeline))
    error_message = "data factory pipeline name must be a valid string type starting with a letter and containing only letters, numbers, dots, underscores, and hyphens."
  }
}

variable "storage_account_name" {
  type = string
  description = "Name of the storage account"

  validation {
    condition = can(regex("^[a-zA-Z][a-zA-Z0-9._-]*$", var.storage_account_name))
    error_message = "storage account name must be a valid string type starting with a letter and containing only letters, numbers, dots, underscores, and hyphens."    
  }
}

variable "blob_event" {
  type = string
  description = "Name of the event that triggers by the blob"

  validation {
    condition = can(regex("^[a-zA-Z][a-zA-Z0-9._-]*$", var.blob_event))
    error_message = "Blob event name must be a valid string type starting with a letter and containing only letters, numbers, dots, underscores, and hyphens."
  }
}

variable "event_grid" {
  type = string
  description = "name of event grid"

  validation {
    condition = can(regex("^[a-zA-Z][a-zA-Z0-9._-]*$", var.event_grid))
    error_message = "event grid name must be a valid string type starting with a letter and containing only letters, numbers, dots, underscores, and hyphens."
  }
}

variable "service_plan" {
  type = string
  description = "name of service plan"

  validation {
    condition = can(regex("^[a-zA-Z][a-zA-Z0-9._-]*$", var.service_plan))
    error_message = "Service plan name must be a valid string type starting with a letter and containing only letters, numbers, dots, underscores, and hyphens."
  }
}

variable "function_app" {
  type = string
  description = "name of the function app"

  validation {
    condition = can(regex("^[a-zA-Z][a-zA-Z0-9._-]*$", var.function_app))
    error_message = "Function app name must be a valid string type starting with a letter and containing only letters, numbers, dots, underscores, and hyphens."
  }
}

variable "data_lake" {
  type = string
  description = "name of the data lake"

  validation {
    condition = can(regex("^[a-zA-Z][a-zA-Z0-9._-]*$", var.data_lake))
    error_message = "Data Lake name must be a valid string type starting with a letter and containing only letters, numbers, dots, underscores, and hyphens."
  }
}

variable "data_synapse_admin" {
  type = string
  description = "Admin login for the SQL server"

  validation {
    condition     = length(var.data_synapse_admin) >= 8
    error_message = "SQL Server admin login nmust be more 8 characters long"
  }
}

variable "data_synapse_password" {
  type        = string
  description = "Password for Synapse data connection"
  sensitive   = true
  
  validation {
    condition = (
      length(var.data_synapse_password) >= 8 &&
      can(regex(".*[A-Z].*", var.data_synapse_password)) &&
      can(regex(".*[0-9].*", var.data_synapse_password)) &&
      can(regex(".*[^A-Za-z0-9].*", var.data_synapse_password))
    )
    error_message = "Password must be at least 8 characters long and include at least one uppercase letter, one number, and one special character."
  }
}

variable "data_stream" {
  type = string
  description = "name of the data stream"

  validation {
    condition = can(regex("^[a-zA-Z][a-zA-Z0-9._-]*$", var.data_stream))
    error_message = "Data stream name must be a valid string type starting with a letter and containing only letters, numbers, dots, underscores, and hyphens."
  }
}

variable "data_synapse" {
  type = string
  description = "name of the data synapse"

  validation {
    condition = can(regex("^[a-zA-Z][a-zA-Z0-9._-]*$", var.data_synapse))
    error_message = "Data Synapse name must be a valid string type starting with a letter and containing only letters, numbers, dots, underscores, and hyphens."
  }
}