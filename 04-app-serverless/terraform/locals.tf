locals {
  lambdas_path = "${path.module}/../app/lambdas"
  layers_path  = "${path.module}/../app/layers/nodejs"
  layer_name   = "joi.zip"

  common_tags = {
    Project   = "TODO Serverless App"
    CreatedAt = "2023-06-19"
    ManagedBy = "Terraform"
    Owner     = "Vinicius Puça Ribeiro"
    Service   = var.service_name
  }
}