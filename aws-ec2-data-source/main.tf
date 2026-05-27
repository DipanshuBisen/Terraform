terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# VPC select by data source
data "aws_vpc" "name" {
  tags = {
    Name = "my-vpc"
  }
}

# Subnet Select by Data Source
data "aws_subnet" "name" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.name.id]
  }
  tags = {
    Name = "private_subnet"
  }
}

# Just to check whether i am able  to access that Subnet or not use output block 
output "mySubnet" {
  value = data.aws_subnet.name.id
}

# Security Group selcet by the Data Source 
data "aws_security_group" "name" {
  tags = {
    name = "sg"
  }
}

# Creating EC2 Instance
resource "aws_instance" "myServer" {
  ami             = "ami-07a00cf47dbbc844c"
  instance_type   = "t3.micro"
  subnet_id       = data.aws_subnet.name.id
  security_groups = [data.aws_security_group.name.id]

  tags = {
    Name = "Myserver"
  }
}
