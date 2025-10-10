variable "bucket_name" {
  description = "Name of the S3 bucket for hosting the fortune site"
  type        = string
  default     = "terraform-fortune-site-shinya"
}

variable "environment" {
  description = "Deployment environment tag"
  type        = string
  default     = "Dev"
}

variable "bucket_tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
  default = {
    Name        = "FortuneSiteBucket"
    Environment = var.environment
  }
}

variable "cloudfront_tags" {
  description = "Tags for the CloudFront distribution"
  type        = map(string)
  default = {
    Name        = "FortuneSiteCDN"
    Environment = var.environment
  }
}
