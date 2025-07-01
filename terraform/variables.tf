variable "project_name" {
  type        = string
  default     = "tf-globals"
  description = "Name of the Github Repo"
}

variable "environment" {
  type        = string
  default     = "development"
  description = "Environment name (e.g., development, staging, production)"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "bucket_name_prefix" {
  type        = string
  default     = "frontend-assets"
  description = "Name prefix for the bucket (e.g., frontend-assets)"
}

variable "suffix" {
  type        = string
  default     = "8864"
  description = "First 4 digits of the AWS account ID"
}
