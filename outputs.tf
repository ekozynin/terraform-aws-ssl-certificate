output "arn" {
  description = "SSL certificate"
  value = aws_acm_certificate.ssl_certificate.arn
}
