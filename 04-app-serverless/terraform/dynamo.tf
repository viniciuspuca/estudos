resource "aws_dynamodb_table" "this" {
  hash_key       = "TodoID"
  name           = var.service_name
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "TodoID"
    type = "S"
  }

  tags = local.common_tags
}