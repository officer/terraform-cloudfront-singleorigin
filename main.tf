resource "aws_cloudfront_distribution" "distribution" {
    default_root_object = "index.html"
    enabled             = true
    viewer_certificate  {
      acm_certificate_arn = "${var.certificate_arn}"
      ssl_support_method  = "vip"
    }
    aliases             = "${var.alias_domain_names}"
    is_ipv6_enabled     = true
    

    origin {
      domain_name = "${var.origin_domain_name}"
      origin_id   = "primary"

      custom_origin_config {
        http_port = 80
        https_port = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols = [
          "TLSv1",
          "TLSv1.1",
          "TLSv1.2"
        ]
      }
    }

    default_cache_behavior {
      allowed_methods   = ["GET", "HEAD", "OPTIONS"]
      cached_methods     = ["GET", "HEAD", "OPTIONS"]
      target_origin_id  = "primary"

      viewer_protocol_policy = "redirect-to-https"
      min_ttl                = 0
      default_ttl            = 3600
      max_ttl                = 86400
      forwarded_values {
        query_string = false

        cookies {
          forward = "none"
        }
      }
    }

    restrictions {
      geo_restriction {
        restriction_type = "none"
      }
    }

    logging_config {
      include_cookies = true
      bucket = "${module.logging_bucket.bucket.bucket_domain_name}"
    }

}

# logging bucket
module "logging_bucket" {
  source    = "github.com/officer/terraform-logging-bucket.git"
  region    = "${data.aws_region.current.name}"
  namespace = "cflog"
  tags      = "${var.tags}"
}