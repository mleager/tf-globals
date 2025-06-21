terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.99.1"
    }
  }
  required_version = ">= 1.12.1"
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Name        = "${var.bucket_name_prefix}-${var.environment}"
      Environment = var.environment
    }
  }
}

