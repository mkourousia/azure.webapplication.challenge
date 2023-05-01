<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.54.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_web_app.skedda_challenge_web_app_dr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_service_plan.skedda_challenge_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_mssql_server.secodary_mssql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mssql_server) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_mssql_password"></a> [azure\_mssql\_password](#input\_azure\_mssql\_password) | n/a | `string` | n/a | yes |
| <a name="input_azure_mssql_username"></a> [azure\_mssql\_username](#input\_azure\_mssql\_username) | n/a | `string` | `"maria"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"skedda-challenge"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | <pre>object({<br>    app = string<br>  })</pre> | <pre>{<br>  "app": "skedda-challenge"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_web_app"></a> [web\_app](#output\_web\_app) | n/a |
<!-- END_TF_DOCS -->