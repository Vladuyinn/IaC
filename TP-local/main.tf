terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.5.0"
    }
  }
}

provider "docker" {
  host = "tcp://localhost:2375"
}

resource "docker_image" "nginx" {
  name         = var.image_name
  keep_locally = true
}

resource "docker_container" "nginx" {
  name  = var.container_name
  image = docker_image.nginx.image_id
  
  ports {
    internal = var.internal_port
    external = var.external_port
  }

  networks_advanced {
    name    = docker_network.app_network.name
    aliases = ["nginx"]
  }
}

resource "docker_network" "app_network" {
  name = "app_network"
}

resource "docker_image" "curl" {
  name         = "appropriate/curl:latest"
  keep_locally = true
}

resource "docker_container" "client" {
  name  = "client"
  image = docker_image.curl.image_id

  # Connexion au même réseau
  networks_advanced {
    name = docker_network.app_network.name
  }

  command = ["sh", "-c", "curl -s http://nginx:80 && sleep 3600"]

  depends_on = [docker_container.nginx]
}

output "nginx_container_id" {
  description = "L'identifiant du conteneur Nginx créé"
  value       = docker_container.nginx.id
}