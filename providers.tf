provider "azurerm" {
  features {}
  subscription_id = var.subscription-id
  client_id       = var.client-id
  client_secret   = var.secret
  tenant_id       = var.tenant-id
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.78.0"
    }
  }
}