resource "random_pet" "random_name" {
  length = 3
}

resource "aws_s3_bucket" "bucket_s3" {
  bucket = "bucket-terraform-${random_pet.random_name.id}"
}

resource "aws_s3_bucket_ownership_controls" "bucket_s3" {
  bucket = aws_s3_bucket.bucket_s3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket_s3" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket_s3]

  bucket = aws_s3_bucket.bucket_s3.id
  acl    = "private"
}

resource "aws_s3_object" "objeto_bucket" {
  bucket       = aws_s3_bucket.bucket_s3.bucket
  key          = "instances/instances-${local.instance.ami}.json"
  source       = "output.json"
  etag         = filemd5("output.json")
  content_type = "application/json"
}