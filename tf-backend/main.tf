
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
  }
  backend "" {
    bucket = "dipanshu-7ea935fdf4424ea3"
    key = "backend.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "myserver" {
    ami = "ami-05d2d839d4f73aafb"
    instance_type = "t3.micro"
    tags = {
      Name = "Sample"
    }
}