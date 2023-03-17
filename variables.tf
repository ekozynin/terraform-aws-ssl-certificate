variable "domain_name" {
  type        = string
  description = "domain name for which certificate is required, ex. www.example.com"
}

variable "hosted_zone_id" {
  type        = string
  description = "Route 53 hosted zone id, where validation DNS record for the certificate will be created"
}