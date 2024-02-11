terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.31.0"
    }
  }
}



provider "aws" {
  region  = <your aws region>
  profile = "default"
}