terraform {
  required_providers {
    aws ={
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "name" {
  most_recent = true
  owners = ["amazon"]
}

output "aws-ami" {
    value = data.aws_ami.name
  
}

resource "aws_instance" "mywebserver" {
  ami = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  tags = {
    Name = "mywebserver"
  }
}