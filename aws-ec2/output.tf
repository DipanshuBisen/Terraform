output "aws-insatnce-public-ip" {
    value = aws_instance.myserver.public_ip  
}