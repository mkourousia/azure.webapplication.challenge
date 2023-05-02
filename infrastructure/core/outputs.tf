output "web_app_service_id" {
  value       = azurerm_linux_web_app.skedda_challenge_web_app.id
  description = "The resource id of the Azure App Service that is created"
}

output "web_app_mssql_server_id" {
  value       = azurerm_mssql_server.skedda_challenge_mssql_server.id
  description = "The resource id of the Azure SQL Server that is created"
}

output "web_app_mssql_database_id" {
  value       = azurerm_mssql_database.skedda_challenge_mssql_db.id
  description = "The resource id of the Azure SQL Database that is created"
}