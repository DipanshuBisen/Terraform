output "insatnce-url" {
  description = "The url to access the nginx server"
  value = "http://${aws_instance.pub-nginxserver.public_ip}"
}

output "instance-public-ip" {
  description = "Public IP address of EC2 insatnce"
  value = aws_instance.pub-nginxserver.public_ip
}