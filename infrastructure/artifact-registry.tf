resource "google_artifact_registry_repository" "my-docker-repo" {
  provider      = google-beta
  location      = var.project_region
  repository_id = var.repository_id
  description   = "docker repository"
  format        = "DOCKER"
}