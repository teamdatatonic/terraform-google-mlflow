output "lb_ip" {
  value = module.mlflow.load_balancer_ip
}

output "oauth_redirect_url" {
  value = module.mlflow.oauth_redirect_url
}

output "brand_name" {
  value = module.mlflow.created_brand_name
}
