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

resource "aws_instance" "myserver" {
  ami = "ami-07a00cf47dbbc844c"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size = 30
    volume_type = "gp2"
  }
  tags = {
    name ="myserver"
  }
}