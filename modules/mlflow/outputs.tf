output "cloud_run_service" {
  value = module.cloud_run.service_name
}

output "cloud_run_service_url" {
  value = module.cloud_run.service_url
}

output "artifacts_bucket_name" {
  value = module.artifacts.name
}

output "load_balancer_ip" {
  value = module.cloud_run.load_balancer_ip
}

output "oauth_redirect_url" {
  value = module.cloud_run.oauth_redirect_url
}

output "created_brand_name" {
  value = module.cloud_run.created_brand_name
}
