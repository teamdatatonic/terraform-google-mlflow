resource "google_storage_bucket" "mlflow_artifacts_bucket" {
  project       = var.project_id
  name          = var.bucket_name
  location      = var.bucket_location
  storage_class = var.storage_class
  versioning {
    enabled = var.versioning_enabled
  }
  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = var.number_of_versions
    }
  }
  uniform_bucket_level_access = var.storage_uniform
  force_destroy               = true
}
