provider "aws" {
  region  = local.region
  profile = local.profile
}

locals {
    bucket_name = "s3-bucket-${random_pet.this.id}"
    region      = "us-east-1"
    profile     = "terraform"
}

resource "random_pet" "this" {
    length = 3
}

resource "aws_iam_role" "this" {
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "bucket_policy" {
    statement {
      principals {
        type = "AWS"
        identifiers = [aws_iam_role.this.arn]
      }

      actions = [
        "s3:ListBucket",
      ]

      resources = [
        "arn:aws:s3:::${local.bucket_name}",
      ]
    }
}

module "s3_bucket" {
    source = "./s3_module"

    bucket = local.bucket_name

    tags = {
      Description = "Bucket para site estatico"
      Owner = "Vinicius Puça Ribeiro"
      Enviroment = "Dev"
      Date = "06/06/2023"
    }
}

attach_policy = true
policy = data.aws_iam_policy_document.bucket_policy.json

control_object_ownership = true
object_ownership = "BucketOwnerPreferred"
expected_bucket_owner = data.aws_caller_identity.current.accoun_id

versioning = {
    status = true
    mfa_delete = false
}

website = {
    index_document = "./website/index.html"
    error_document = "./website/error.html"
}