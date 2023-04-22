# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}


provider "azurerm" {
  subscription_id = "88c7e449-6ac7-4e8e-838d-5702a085812c"
  features {}
}