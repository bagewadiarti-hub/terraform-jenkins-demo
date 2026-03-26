terraform {
  required_providers {
   docker = {
    source = "kreuzwerker/docker"
    version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

resouce "docker_image" "nginx" {
  name = "nginx:alpine"
  keep_locally = true
}

resource "docker_container" "web" {
  name = "jenkins-terraform-ngnix"
  image = docker_image.ngnix.image_id

ports {
  internal = 80
  external = 8090
}
labels {
  label = "deployed_by"
  value = "jenkins-terraform"
}
}

output "container_name" {
  value = docker_container.web.name
}

output "container_url" {
  value = ""http://localhost:8090"
}


