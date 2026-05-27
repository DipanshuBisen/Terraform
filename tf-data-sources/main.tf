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
    value = data.aws_ami.name.id
  
}


# Security Group
data "aws_security_group" "name" {
  tags = {
    mytg = "http"
  }
}

output "aws-SG" {
  value = data.aws_security_group.name.id
}

# VPC 
data "aws_vpc" "name" {
  tags = {
    myVPC = "def"
  }
}

output "aws-VPC" {
  value = data.aws_vpc.name.id
  
}


# Availability Zones
data "aws_availability_zones" "names" {
  state = "available"
}

output "aws-AZ" {
  value = data.aws_availability_zones.names
  
}

# To get the accounts Details
data "aws_caller_identity" "name" {
  
}

output "callername" {
  value = data.aws_caller_identity.name
}

# AwS Region Name
data "aws_region" "name" {
  
}
output "aws-RegionName" {
  value = data.aws_region.name
}

resource "aws_instance" "mywebserver" {
  ami = data.aws_ami.name.id
  instance_type = "t3.micro"
  tags = {
    Name = "mywebserver"
  }
}