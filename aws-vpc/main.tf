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

#create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

#Private subnet
resource "aws_subnet" "private-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "private-subnet"
  }
}

#Public subnet
resource "aws_subnet" "public-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "public-subnet"
  }
}

#Internet Gatewat
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}

#Route Table
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}

# add public subnet in route table
resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.my-rt.id
  subnet_id = aws_subnet.public-subnet.id 
}

# Now create the public and private Ec2 instance
resource "aws_instance" "public-insatnce" {
  ami = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public-subnet.id
  tags = {
    Name = "public-instance"
  }
}

resource "aws_instance" "private-insatnce" {
  ami = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.private-subnet.id
  tags = {
    Name = "private-instance"
  }
}