locals {
  subnet_ids = { for k, v in aws_subnet.this : v.tags.Name => v.id }

  common_tags = {
    Project   = "App Scaling"
    CreatedAt = "2023-06-23"
    ManagedBy = "Terraform"
    Owner     = "Vinicius Puça Ribeiro"
    Service   = "Auto Scaling App"
  }
}