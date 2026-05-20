#give the provider name 

terraform {
  required_providers {
    aws = {
         source  = "hashicorp/aws"
         version = "6.40.0"
    }
  }
}

# give he provider region name 
provider "aws" {
  region = "ap-south-1"
}

resource "aws_launch_template" "MyTemplate" {
  name = "MyTemplate"
  image_id = "ami-07a00cf47dbbc844c"
  instance_type = "t3.micro"
  placement {
    availability_zone = "ap-south-1a"
  }
  user_data = base64encode(<<-EOF
            #!/bin/bash
            sudo apt install nginx -y    
            sudo systemctl start nginx
            echo "Hello from Launch Template" > /var/www/html/index.html
            EOF
    )

   tags = {
    Name = "temp1"
  }

}

#Now Create the target Group
resource "aws_lb_target_group" "MYTG" {
  name = "MYTG"
  target_type = "instance"
  port = 80
  protocol = "HTTP"
  vpc_id      = "vpc-0300b88355e112397"
}

#Now Create the ALB
resource "aws_lb" "ALB" {
  name = "ALB"
    load_balancer_type = "application"
    subnets = [
        "subnet-0a01f6fc7862595de",
        "subnet-08fd438697dcb28db",
        "subnet-06aa129aae7a062b3"
    ]
    
}

#Now Create the Auto Scaling Groups 
resource "aws_autoscaling_group" "ASG" {
    name = "ASG"
    max_size = 5
    min_size = 2
    desired_capacity = 2
    availability_zones =[
        "ap-south-1a",
        "ap-south-1b"
    ] 
    launch_template {
      id = aws_launch_template.MyTemplate.id
      version = "$Latest"
    }
    target_group_arns = [
    aws_lb_target_group.MYTG.arn
  ]

  health_check_type = "ELB"
}



#here you have to create the listner
resource "aws_lb_listener" "myListner" {
    load_balancer_arn = aws_lb.ALB.arn
    port = 80
    protocol = "HTTP"


    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.MYTG.arn
    }

  
}

output "LBURL" {
 value =  aws_lb.ALB.dns_name
}