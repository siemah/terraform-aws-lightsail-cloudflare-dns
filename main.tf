provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "random_pet" "pet" {
  length    = 2
  separator = "-"
}

module "lightsail" {
  source            = "./modules/aws-lightsail"
  availability_zone = var.availability_zone
  blueprint_id      = "wordpress"
  bundle_id         = "micro_2_0"
  environment       = "prod"
  name              = "tf-via-module-wordpress-${random_pet.pet.id}"
  label_order       = ["name", "environment"]
  create_static_ip  = true
  domain_name       = ""
  # public_key           = "ssh-rsa AAAAB3NzaCrmXGb6068G+r3Q9PXtTs42tv1KoKxahY5vDo57RsPN+sQGPIVDclN6PbRm4c9guBwLBYFVQL4PvBOSYHrapXjbheebTQDQoyPV7SM7LK57J0BC8oEfcrTgCIdy9mIWAYFIeTWfj0Xw/c9thxNtSse9XTAH6esdasd+Sucn0XNRwxzM2yOufgfggXqiBWjU+bMDLfQ+QV6gd2kvnBv0wf22s9meldRPZttryhcIO6HfjbbDEk0Oyo66KI70034tVgvAN0"
  use_default_key_pair = true

  port_info = [
    {
      port     = 80
      protocol = "tcp"
      cidrs    = ["0.0.0.0/0"]
    },
    {
      port     = 443
      protocol = "tcp"
      cidrs    = ["0.0.0.0/0"]
    },
    {
      port     = 22
      protocol = "tcp"
      cidrs    = ["0.0.0.0/0"]
    }
  ]
}

# create a new cloudflare dns zone if it is needed
resource "cloudflare_zone" "example_com" {
  account_id = var.cloudflare_account_id
  zone       = var.domain
}

# add A record to point a subdomain to the lightsail static ip
resource "cloudflare_record" "app_a_record" {
  zone_id = cloudflare_zone.example_com.id
  proxied = true
  type    = "A"
  name    = "app"
  value   = module.lightsail.ip_address["0"]
  ttl     = 1
}