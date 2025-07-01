resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "${var.bucket_name_prefix}-${var.environment}-${var.suffix}"

  tags = {
    Name        = "${var.bucket_name_prefix}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.frontend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.frontend_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

