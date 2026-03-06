# 1. Le type d'instance EC2
variable "instance_type" {
  description = "Type de l'instance EC2"
  type        = string
  default     = "t2.micro"
}

# 2. Le nom de l'instance EC2
variable "instance_name" {
  description = "Nom tag de l'instance EC2"
  type        = string
  default     = "nginx-server"
}

# 3. Le nom du bucket S3
variable "bucket_name" {
  description = "Nom du bucket S3"
  type        = string
  default     = "my-bucket"
}

# 4. Le port par défaut pour le groupe de sécurité
variable "web_port" {
  description = "Port d'entrée pour le trafic HTTP"
  type        = number
  default     = 80
}