#aws provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }

  #backend

  backend "s3" {
    bucket         = "brinabh-statefile"
    dynamodb_table = "brinabh_state_lock_table"
    key            = "tf_state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }

}

provider "aws" {
  region = "us-east-1"
}

