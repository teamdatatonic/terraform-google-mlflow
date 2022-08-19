output "logger_email" {
  description = "The email address of the logger service account."
  value       = google_service_account.logger.email
}
