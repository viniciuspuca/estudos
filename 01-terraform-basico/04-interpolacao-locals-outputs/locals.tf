locals {
  ip_filepath = "ips.txt"
  common_tags = {
    Projeto     = "Curso Terraform"
    ManagedBy   = "Terraform"
    Environment = var.enviroment
    Owner       = "Vinicius Puca Ribeiro"
  }
}