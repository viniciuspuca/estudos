variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = ""
  default     = "terraform"
}

variable "aws_account_id" {
  type        = number
  description = ""
  default     = 009667238338
}

variable "service_name" {
  type        = string
  description = ""
  default     = "ToDos"
}

variable "service_domain" {
  type        = string
  description = ""
  default     = "api-viniciuspuca"
}