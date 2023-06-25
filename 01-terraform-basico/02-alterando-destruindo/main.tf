terraform {
    required_version = "1.4.6"

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.66.0"
        }
    }

}

provider "aws" {
  region  = "us-east-1"
  profile = "terraform"
}

resource "aws_s3_bucket" "bucket-terraform-04052023-2235" {
  bucket = "bucket-terraform-04052023-2235"

  tags = {
    Name        = "bucket-terraform-04052023-2235"
    Environment = "Prod"
    ManagedBy   = "Terraform"
    Owner       = "Vinicius Puca Ribeiro"
    UpdateAt    = "2023-05-04"
  }
}

resource "aws_s3_bucket_ownership_controls" "bucket-terraform-04052023-2235" {
  bucket = aws_s3_bucket.bucket-terraform-04052023-2235.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket-terraform-04052023-2235" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket-terraform-04052023-2235]

  bucket = aws_s3_bucket.bucket-terraform-04052023-2235.id
  acl    = "private"
}