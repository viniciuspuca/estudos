resource "random_pet" "random_name" {
  length = 5
}

resource "aws_s3_bucket" "bucket_s3" {
  bucket = "bucket-${random_pet.random_name.id}-${var.env}"
  tags = local.common_tags
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
  key          = "${uuid()}.${local.file_ext}"
  source       = data.archive_file.json.output_path
  etag         = filemd5(data.archive_file.json.output_path)
  content_type = "application/zip"

  tags = local.common_tags
}