Terraform module to create a certificate, and validate it by creating a DNS entry.

Example usage:

```hcl
module "www_certificate" {
  source = "ekozynin/ssl-certificate/aws"
  version = "~> 1.0.0"
  providers = {
    // Cloudfront only supports ACM certs issues in us-east-1
    aws = aws.cloudfront
  }

  domain_name = var.domain_name
  hosted_zone_id = var.hosted_zone_id
}
```
