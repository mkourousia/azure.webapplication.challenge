variable "prefix" {
  type    = string
  default = "skedda-challenge"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "tags" {
  type = object({
    app    = string
  })
  default = {
    app    = "skedda-challenge"
  }
}

variable "azure_mssql_version" {
  type    = string
  default = "12.0"
}

variable "azure_mssql_username" {
  type    = string
  default = "maria"
}

variable "azuread_administrator" {
  type = object({
    login_username              = string
    object_id                   = string
    azuread_authentication_only = bool
  })
  default = {
    azuread_authentication_only = false
    login_username              = "mkourousia"
    object_id                   = "c12cdb8f-6801-4639-96b8-4c6fb3afe3f9"
  }
}

variable "azure_mssql_license_type" {
  type    = string
  default = "LicenseIncluded"
}

variable "azure_mssql_size" {
  type    = number
  default = 2
}

variable "secondary_location" {
  type    = string
  default = "northeurope"
}

variable "deploy_dr_appService" {
  type    = bool
  default = false
}