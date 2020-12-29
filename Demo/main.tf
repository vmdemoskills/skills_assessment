variable "region" {
  type        = string
  description = "AWS Region to build ELK assets"
  default     = "us-east-2"
}

locals {
  common_prefix = "vmsa"
  elk_domain    = "${local.common_prefix}-elk-domain"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "vmsabucket"
    key    = "state/terraform.tfstate"
    region = "us-east-2"
  }
}
