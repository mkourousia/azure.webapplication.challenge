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
    region = string
    app    = string
  })
  default = {
    app    = "skedda-challenge"
    region = "northeurope"
  }
}

variable "azure_mssql_username" {
  type = string
}

variable "azure_mssql_password" {
  type = string
}
