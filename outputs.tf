output "s3_website_url" {
  description = "URL of the S3 static website"
  value       = aws_s3_bucket.fortune_site.website_endpoint
}

output "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.cdn.domain_name
}
