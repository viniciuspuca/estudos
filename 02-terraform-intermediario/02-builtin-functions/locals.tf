locals {
  instance_number = lookup(var.instance_number, var.env)
  file_ext        = "zip"
  object_name     = "arquivo-criado-por-template"

  common_tags     = {
    "Owner" = "Vinicius Puca Ribeiro"
    "Year"  = "2023"
  }
}