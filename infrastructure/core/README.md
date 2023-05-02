<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.53.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_web_app.skedda_challenge_web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_mssql_database.skedda_challenge_mssql_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |
| [azurerm_mssql_failover_group.skedda_challenge_failover_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_failover_group) | resource |
| [azurerm_mssql_firewall_rule.skedda_challenge_mssql_firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_firewall_rule.skedda_challenge_mssql_firewall_secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_server.skedda_challenge_mssql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_mssql_server.skedda_challenge_mssql_server_secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_resource_group.skedda_challenge_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.skedda_challenge_resource_group_dr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_service_plan.skedda_challenge_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [random_password.mssql_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_mssql_license_type"></a> [azure\_mssql\_license\_type](#input\_azure\_mssql\_license\_type) | n/a | `string` | `"LicenseIncluded"` | no |
| <a name="input_azure_mssql_size"></a> [azure\_mssql\_size](#input\_azure\_mssql\_size) | n/a | `number` | `2` | no |
| <a name="input_azure_mssql_username"></a> [azure\_mssql\_username](#input\_azure\_mssql\_username) | n/a | `string` | `"maria"` | no |
| <a name="input_azure_mssql_version"></a> [azure\_mssql\_version](#input\_azure\_mssql\_version) | n/a | `string` | `"12.0"` | no |
| <a name="input_azuread_administrator"></a> [azuread\_administrator](#input\_azuread\_administrator) | n/a | <pre>object({<br>    login_username              = string<br>    object_id                   = string<br>    azuread_authentication_only = bool<br>  })</pre> | <pre>{<br>  "azuread_authentication_only": false,<br>  "login_username": "mkourousia",<br>  "object_id": "c12cdb8f-6801-4639-96b8-4c6fb3afe3f9"<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"skedda-challenge"` | no |
| <a name="input_secondary_location"></a> [secondary\_location](#input\_secondary\_location) | n/a | `string` | `"northeurope"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | <pre>object({<br>    app = string<br>  })</pre> | <pre>{<br>  "app": "skedda-challenge"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_web_app_mssql_database_id"></a> [web\_app\_mssql\_database\_id](#output\_web\_app\_mssql\_database\_id) | The resource id of the Azure SQL Database that is created |
| <a name="output_web_app_mssql_server_id"></a> [web\_app\_mssql\_server\_id](#output\_web\_app\_mssql\_server\_id) | The resource id of the Azure SQL Server that is created |
| <a name="output_web_app_service_id"></a> [web\_app\_service\_id](#output\_web\_app\_service\_id) | The resource id of the Azure App Service that is created |
<!-- END_TF_DOCS -->