variable "image_name" {
  description = "Le nom de l'image Docker"
  type        = string
  default     = "nginx:latest"
}

variable "container_name" {
  description = "Le nom du conteneur"
  type        = string
  default     = "nginx-terraform"
}

variable "external_port" {
  description = "Le port externe exposé"
  type        = number
  default     = 8090
}

variable "internal_port" {
  description = "Le port interne du conteneur"
  type        = number
  default     = 80
}