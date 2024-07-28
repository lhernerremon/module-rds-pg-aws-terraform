terraform {
  required_version = ">= 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.58"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5"
    }
  }
}
