terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_container" "jenkins" {
  image = "jenkins/jenkins"
  name  = "jenkins-server"

  ports {
    internal = 8080
    external = 8080
  }
}
