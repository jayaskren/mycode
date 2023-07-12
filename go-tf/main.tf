/* main.tf */

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "gosvr" {
  # the name of our go image
  name         = var.image_name
  keep_locally = true // keep image after "destroy"
}

resource "docker_container" "gosvr" {
  image = docker_image.gosvr.image_id
  name  = var.container_name
  ports {
    internal = 9876
    external = 2224
  }
}

data "http" "ping" {
  url="http://localhost:2224/ping"
  depends_on=[resource.docker_container.gosvr]
}

output "ping_response" {
  value = data.http.ping.response_body
}

