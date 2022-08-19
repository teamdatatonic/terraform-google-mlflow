output "url" {
  description = "gcs uri"
  value       = google_storage_bucket.mlflow_artifacts_bucket.url
}

output "name" {
  description = "gcs bucket name"
  value       = google_storage_bucket.mlflow_artifacts_bucket.name
}
