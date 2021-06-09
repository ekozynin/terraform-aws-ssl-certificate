variable "domain_name" {
  type = string
  description = "domain name for the website (no naked domains allowed), ex. www.example.com"
}

variable "hosted_zone_id" {
  type        = string
  description = "Route 53 hosted zone id for the domain to redirect"
}