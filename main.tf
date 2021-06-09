resource "aws_acm_certificate" "ssl_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "dns_validation_record" {
  zone_id = var.hosted_zone_id
  ttl     = 60

  for_each = {
    for dvo in aws_acm_certificate.ssl_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
}

resource "aws_acm_certificate_validation" "ssl_certtificate_validation" {
  certificate_arn         = aws_acm_certificate.ssl_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.dns_validation_record : record.fqdn]

  // when the certificate is issued & validated, it is not immediately available
  // so adding 15 seconds sleep, to let the certificate information propagate
  // TODO still need this?
//  provisioner "local-exec" {
//    command = "echo '-----> waiting for a new certificate to become available...' && sleep 15"
//  }
}