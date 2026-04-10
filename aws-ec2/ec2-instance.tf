

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "myserver" {
  ami = "ami-048f4445314bcaa09"
  instance_type = "t3.small"
  tags = {
    Name = "SampleServer"
  }
}