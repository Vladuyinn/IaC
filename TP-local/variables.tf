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

variable "server_names" {
  description = "Liste des noms pour les serveurs clients"
  type        = set(string)
  default     = ["alpha", "beta", "gamma"] # Vous pouvez mettre les noms que vous voulez
}

variable "machines" {
  description = "Liste des machines virtuelles à déployer avec leurs caractéristiques"
  
  type = list(object({
    nom       = string
    vcpu      = number
    disk_size = number
    region    = string
  }))

  validation {
    condition     = alltrue([for m in var.machines : m.vcpu >= 2 && m.vcpu <= 64])
    error_message = "Erreur : Le nombre de vCPU doit être compris entre 2 et 64 pour toutes les machines."
  }

  validation {
    condition     = alltrue([for m in var.machines : m.disk_size >= 20])
    error_message = "Erreur : La taille du disque (disk_size) doit être d'au moins 20 Go pour toutes les machines."
  }
  
  validation {
    condition     = alltrue([for m in var.machines : contains(["eu-west-1", "us-east-1", "ap-southeast-1"], m.region)])
    error_message = "Erreur : La région doit être exactement 'eu-west-1', 'us-east-1' ou 'ap-southeast-1'."
  }
}