output "secret_value" {
  description = "value of the password created by the secret manager"
  value       = google_secret_manager_secret_version.secret-version.secret_data
  sensitive   = true
}
