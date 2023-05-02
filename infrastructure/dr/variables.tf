variable "prefix" {
  type    = string
  default = "skedda-challenge-mk"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "tags" {
  type = object({
    app = string
  })
  default = {
    app = "skedda-challenge"
  }
}

variable "azure_mssql_username" {
  type    = string
  default = "maria"
}

variable "azure_mssql_password" {
  type = string
}
