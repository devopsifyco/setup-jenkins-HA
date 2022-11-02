terraform {
  cloud {
    organization = "devopsify"

    workspaces {
      name = "jenkins-HA"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}
