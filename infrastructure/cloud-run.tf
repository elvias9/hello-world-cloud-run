locals {
  app_image = "${var.project_region}-docker.pkg.dev/${var.project_id}/${var.repository_id}/app:latest"
}

resource "null_resource" "build_and_push" {
  provisioner "local-exec" {
    command = "sh build-image.sh ${local.app_image}"
  }

  depends_on = [google_artifact_registry_repository.my-docker-repo]
}


resource "google_cloud_run_service" "run_service" {
  provider = google-beta
  project  = var.project_id
  name     = var.service_name
  location = var.project_region
  template {
    spec {
      containers {
        image = local.app_image
        ports {
          name           = "http1"
          container_port = "80"
        }
      }
    }
  }

  metadata {
    annotations = {
      "run.googleapis.com/ingress" = "internal-and-cloud-load-balancing"
    }
  }

  autogenerate_revision_name = true
  traffic {
    percent         = 100
    latest_revision = true
  }

  lifecycle {
    ignore_changes = [template[0].spec[0].containers[0].image]
  }


  depends_on = [null_resource.build_and_push]
}

resource "google_cloud_run_service_iam_member" "allUsers" {
  service  = google_cloud_run_service.run_service.name
  location = google_cloud_run_service.run_service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}


