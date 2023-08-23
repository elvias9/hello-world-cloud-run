resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  provider              = google-beta
  name                  = "serverless-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.project_region
  cloud_run {
    service = google_cloud_run_service.run_service.name
  }
}

module "serverless-lb-http" {
  source               = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version              = "~> 5.1"
  project              = var.project_id
  name                 = "cloud-run-lb"
  ssl                  = true
  ssl_certificates     = [google_compute_ssl_certificate.example.self_link]
  use_ssl_certificates = true
  https_redirect       = true
  backends = {
    default = {
      description             = null
      protocol                = "HTTP"
      port_name               = "http"
      enable_cdn              = false
      custom_request_headers  = null
      custom_response_headers = null
      security_policy         = null
      compression_mode        = null


      log_config = {
        enable      = true
        sample_rate = 1.0
      }

      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
  }
}