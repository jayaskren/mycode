terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "registry.gitlab.com/alta3/simplegoservice:latest"
  keep_locally = true    // keep image after "destroy"
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id

  name = var.container_name
  ports {
    internal = var.internal_port
    external = var.external_port
  }
}


