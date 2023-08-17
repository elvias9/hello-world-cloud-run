resource "google_artifact_registry_repository" "my-docker-repo" {
  provider      = google-beta
  location      = var.project_region
  repository_id = "my-docker-repo"
  description   = "docker repository"
  format        = "DOCKER"
}