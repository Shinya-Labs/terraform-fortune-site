provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "fortune_site" {
  bucket = "terraform-fortune-site-shinya"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Name        = "FortuneSiteBucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.fortune_site.id
  key    = "index.html"
  source = "html/index.html"
  acl    = "public-read"
  content_type = "text/html"
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = aws_s3_bucket.fortune_site.website_endpoint
    origin_id   = "S3-FortuneSite"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-FortuneSite"

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name        = "FortuneSiteCDN"
    Environment = "Dev"
  }
}
