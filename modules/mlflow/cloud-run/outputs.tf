output "service_name" {
  value = google_cloud_run_service.mlflow_service.name
}

output "service_location" {
  value = google_cloud_run_service.mlflow_service.location
}
output "service_url" {
  value = google_cloud_run_service.mlflow_service.status[0].url
}
output "load_balancer_ip" {
  value = module.lb-http.external_ip
}

output "oauth_redirect_url" {
  value = format("https://iap.googleapis.com/v1/oauth/clientIds/%s:handleRedirect", var.oauth_client_id == "" ? google_iap_client.project_client[0].id : var.oauth_client_id)
}

output "created_brand_name" {
  value = var.create_brand == 1 ? google_iap_brand.project_brand[0].name : var.brand_name
}
