variable "prefix" {
  type    = string
  default = "skedda-challenge"
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "tags" {
  type = object({
    region = string
    app    = string
  })
}

variable "azure_mssql_version" {
  type    = string
  default = "12.0"
}

variable "azure_mssql_username" {
  type = string
}

# variable "azure_mssql_password" {
#   type      = string
#   sensitive = true
# }

variable "azuread_administrator" {
  type = object({
    login_username              = string
    object_id                   = string
    azuread_authentication_only = bool
  })
}

variable "azure_mssql_license_type" {
  type    = string
  default = "LicenseIncluded"
}

variable "azure_mssql_size" {
  type = number
}