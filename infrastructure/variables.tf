variable "project_id" {
  type = string
}

variable "project_region" {
  type    = string
  default = "europe-west2"
}

variable "repository_id" {
  type    = string
  default = "my-docker-repo"
}

variable "service_name" {
  type    = string
  default = "helloworld-app"
}
