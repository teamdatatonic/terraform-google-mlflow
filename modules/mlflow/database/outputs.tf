output "instance_connection_name" {
  description = "Connection string used to connect to the db instance"
  value       = google_sql_database_instance.mlflow_db_instance.connection_name
}

output "private_ip" {
  description = "Private IP of the db instance"
  value       = google_sql_database_instance.mlflow_db_instance.private_ip_address
}

output "database_name" {
  description = "Database name"
  value       = google_sql_database.mlflow_db.name
}
