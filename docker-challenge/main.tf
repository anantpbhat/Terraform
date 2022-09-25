# main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}
provider "docker" {}
resource "docker_image" "simpleflask" {
  name         = "registry.gitlab.com/alta3research/simpleflaskservice:1.0"
  keep_locally = true       // keep image after "destroy"
}
resource "docker_container" "flaskcontainer" {
  image = docker_image.simpleflask.latest
  name  = var.container_name
  ports {
    internal = var.int_port
    external = var.ext_port
  }
}
