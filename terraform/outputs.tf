output "frontend_bucket_name" {
  description = "Name of the frontend static assets S3 bucket"
  value       = aws_s3_bucket.frontend_bucket.id
}

output "frontend_bucket_arn" {
  description = "URL of the frontend static assets S3 bucket"
  value       = aws_s3_bucket.frontend_bucket.arn
}

