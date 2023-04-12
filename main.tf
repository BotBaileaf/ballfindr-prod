terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  cloud {
    organization = "REPLACE_ME"

    workspaces {
      name = "learn-terraform-github-actions"
    }
  }
  required_version = ">= 1.1.0"
}
#dgdgdf
