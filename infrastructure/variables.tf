variable "project_id" {
  type    = string
  default = "cr-lab-esicuro-1408230459"
}

variable "project_region" {
  type    = string
  default = "europe-west2"
}

variable "image" {
  type    = string
  default = "gcr.io/cloudrun/hello"
}

variable "service_name" {
  type    = string
  default = "helloworld-app"
}
