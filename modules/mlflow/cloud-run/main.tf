data "google_project" "project" {
  project_id = var.project_id
}
resource "google_vpc_access_connector" "connector" {
  name          = "vpc-mlflow-connector"
  provider      = "google-beta"
  ip_cidr_range = "10.8.0.0/28"
  region        = var.region
  network       = var.network_short_name
}

resource "google_project_iam_member" "cloud_sql" {
  project = data.google_project.project.project_id
  role    = "roles/cloudsql.client"
  member  = format("serviceAccount:%s@appspot.gserviceaccount.com", data.google_project.project.project_id)
}

resource "google_project_iam_member" "secret" {
  project = data.google_project.project.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = format("serviceAccount:%s@appspot.gserviceaccount.com", data.google_project.project.project_id)
}

resource "google_project_iam_member" "gcs" {
  project = data.google_project.project.project_id
  role    = "roles/storage.admin"
  member  = format("serviceAccount:%s@appspot.gserviceaccount.com", data.google_project.project.project_id)
}

resource "google_cloud_run_service" "mlflow_service" {
  name     = "mlflow-service"
  project  = var.project_id
  location = var.region

  metadata {
    annotations = {
      "run.googleapis.com/ingress" = "internal-and-cloud-load-balancing"
    }
  }

  template {
    spec {
      containers {
        image = var.docker_image_name
        env {
          name  = "DB_PASSWORD"
          value = var.db_password
        }
        env {
          name  = "DB_USERNAME"
          value = var.db_username
        }
        env {
          name  = "DB_NAME"
          value = var.db_name
        }
        env {
          name  = "DB_PRIVATE_IP"
          value = var.db_private_ip
        }
        env {
          name  = "GCP_BUCKET"
          value = var.gcs_backend
        }
      }
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"        = "5"
        "run.googleapis.com/cloudsql-instances"   = var.db_instance
        "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.connector.name
      }
    }
  }

  depends_on = [
    google_project_iam_member.gcs,
    google_project_iam_member.cloud_sql,
    google_project_iam_member.secret
  ]

}

resource "google_iap_brand" "project_brand" {
  count             = var.create_brand == 1 ? 1 : 0
  support_email     = var.support_email
  application_title = "mlflow"
  project           = data.google_project.project.number
}

resource "google_iap_client" "project_client" {
  count        = var.oauth_client_id == "" ? 1 : 0
  display_name = "mlflow"
  brand        = var.create_brand == 1 ? google_iap_brand.project_brand[0].name : var.brand_name
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  provider              = google
  name                  = "mlflow-serverless-neg"
  network_endpoint_type = "SERVERLESS"
  project               = var.project_id
  region                = var.region
  cloud_run {
    service = google_cloud_run_service.mlflow_service.name
  }
}

module "lb-http" {
  source  = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version = "6.2.0"

  project = var.project_id
  name    = var.lb_name

  ssl                             = true
  managed_ssl_certificate_domains = [var.domain]
  https_redirect                  = true

  backends = {
    default = {
      description = "mlflow-serverless-neg"
      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]
      enable_cdn              = false
      security_policy         = null
      custom_request_headers  = null
      custom_response_headers = null

      iap_config = {
        enable               = true
        oauth2_client_id     = var.oauth_client_id == "" ? google_iap_client.project_client[0].id : var.oauth_client_id
        oauth2_client_secret = var.oauth_client_secret == "" ? google_iap_client.project_client[0].secret : var.oauth_client_secret
      }
      log_config = {
        enable      = true
        sample_rate = 1.0
      }
    }
  }
}

data "google_iam_policy" "iap" {
  binding {
    role    = "roles/iap.httpsResourceAccessor"
    members = concat(var.webapp_users, ["serviceAccount:${var.logger_email}"])
  }
}

resource "google_iap_web_backend_service_iam_policy" "policy" {
  project             = var.project_id
  web_backend_service = "${var.lb_name}-backend-default"
  policy_data         = data.google_iam_policy.iap.policy_data
  depends_on = [
    module.lb-http
  ]
}
