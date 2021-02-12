terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 2.40.0"
    }
  }
#   backend "azurerm" {}
}

provider "azurerm" {
  features {}
  subscription_id = ""
  tenant_id = ""
  skip_credentials_validation = true
  skip_provider_registration = true
  client_id = ""
  client_secret = ""
}

resource "azurerm_resource_group" "example" {
  name     = "rlg-devops-demo-rg"
  location = "UK South"
}

resource "azurerm_app_service_plan" "example" {
  name                = "rlg-devops-demo-asp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Free"
    size = "F1"

  }
}

resource "azurerm_app_service" "example" {
  name                = "rlg-devops-demo-API"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
  

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
    use_32_bit_worker_process = true 
    cors {
      allowed_origins = [ "*" ]
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "WEBSITE_ENABLE_SYNC_UPDATE_SITE" = "true"
  }

  
}

resource "azurerm_app_service" "SPA" {
  name                = "rlg-devops-demo-SPA"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
    use_32_bit_worker_process = true
  }

}
