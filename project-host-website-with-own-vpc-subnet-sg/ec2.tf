resource "aws_instance" "pub-nginxserver" {
  ami = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids = [ aws_security_group.nginx-sg.id ]
  associate_public_ip_address = true
  user_data = <<-EOF
            #!/bin/bash
            sudo apt install nginx -y    
            sudo systemctl start nginx
            EOF
  tags = {
    Name = "pub-nginxserver"
  }
}