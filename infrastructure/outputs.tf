output "load-balancer-ip" {
  value       = module.serverless-lb-http.external_ip
  description = "IP Address used by Load Balancer"
}

output "cloud_run_url" {
  value       = element(google_cloud_run_service.run_service.status, 0).url
  description = "The URL on which the deployed service is available"
}