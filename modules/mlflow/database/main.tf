resource "random_id" "db_name_suffix" {
  byte_length = 5
}

resource "google_sql_database_instance" "mlflow_db_instance" {
  project          = var.project_id
  name             = "${var.instance_prefix}-${random_id.db_name_suffix.hex}"
  database_version = var.db_version
  region           = var.region

  settings {
    tier = var.db_tier

    # for a private_ip instance, the following two lines are required
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network_self_link
    }
    backup_configuration {
      enabled = true
    }
    availability_type = var.availability_type
  }
  deletion_protection = false
}

# resource "google_sql_ssl_cert" "client_cert" {
#   project = var.project_id
#   common_name = "mlflow-client-cert"
#   instance = google_sql_database_instance.mlflow_db_instance.name
# }

resource "google_sql_database" "mlflow_db" {
  project    = var.project_id
  name       = var.db_name
  instance   = google_sql_database_instance.mlflow_db_instance.name
  depends_on = [google_sql_database_instance.mlflow_db_instance]
}

resource "google_sql_user" "mlflow_db_user" {
  project    = var.project_id
  name       = var.username
  instance   = google_sql_database_instance.mlflow_db_instance.name
  password   = var.password
  depends_on = [google_sql_database_instance.mlflow_db_instance]
}
