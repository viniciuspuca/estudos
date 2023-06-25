output "bucket_name" {
  value = aws_s3_bucket.bucket_s3.bucket
}

output "bucket_arn" {
  value       = aws_s3_bucket.bucket_s3.arn
  description = ""
}

output "bucket_domain_name" {
  value = aws_s3_bucket.bucket_s3.bucket_domain_name
}

output "complete_filepath" {
  value = "${aws_s3_bucket.bucket_s3.bucket}/${aws_s3_object.objeto_bucket.key}"
}