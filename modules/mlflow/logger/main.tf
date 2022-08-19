resource "google_service_account" "logger" {
  project      = var.project_id
  account_id   = "mlflow-logger"
  display_name = "mlflow logger"
}
resource "google_storage_bucket_iam_member" "logger_storage" {
  bucket = var.artifacts_bucket
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.logger.email}"
}
