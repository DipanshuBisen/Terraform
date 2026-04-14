terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.54.1"
    }
    random = {
        source = "hashicorp/random"
        version = "3.6.2"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

provider "random" {

}

resource "random_id" "myid" {
  byte_length = 8
}


resource "aws_s3_bucket" "mybucket" {
  bucket = "dipanshu-${random_id.myid.hex}"
}

# this one for turn off block public access
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# now add the policy 
resource "aws_s3_bucket_policy" "mypolicy" {
  bucket = aws_s3_bucket.mybucket.id
  policy = jsonencode(
    {
    Version = "2012-10-17",
    Statement = [
        {
            Sid = "PublicReadGetObject",
            Effect = "Allow",
            Principal = "*",
            Action = "s3:GetObject",
             Resource = "arn:aws:s3:::${aws_s3_bucket.mybucket.id}/*"
        }
    ]
}
  )
}

#Now doing the website configuration
resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.mybucket.bucket
  source = "./index.html"
  key = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "styles_css" {
  bucket = aws_s3_bucket.mybucket.bucket
  source = "./styles.css"
  key = "styles.css"
  content_type = "text/css"
}

output "name" {
  value = aws_s3_bucket_website_configuration.mywebapp.website_endpoint
}