terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.54.1"
    
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

provider "random" {
  # Configuration options
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "bucket_tag" {
  bucket = "dipanshu-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "bucket_obj" {
    bucket = "dipanshu-${random_id.rand_id.hex}"
    source = "./text.txt"
    key = "text1.txt"
}
output "name" {
  value = random_id.rand_id.hex
}