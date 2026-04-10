terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.54.1"
    
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "dipanshu-bucket-15"
}

resource "aws_s3_object" "bucket-data" {
    bucket = "dipanshu-bucket-15"
    source = "./myfile.txt"
    key = "mydata.txt"
}