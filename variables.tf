variable "lightsail_name" {
  description = "Lightsail instance name"
  type        = string
  default     = "terraform-lightsail-instance"
}

variable "aws_region" {
  description = "Global AWS region"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone of the new Lightsail instance"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare api token"
  type        = string
}

variable "domain" {
  description = "Domain or subdomain of the new server"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Cloudflare account ID"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID"
  type        = string
}