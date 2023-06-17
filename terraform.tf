terraform {

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.4.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }

  }

  required_version = ">= 1.5.0"
}
