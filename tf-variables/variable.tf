variable "aws_instance_type" {
  description = "Give the instance type name for Instance!"
  type = string
  validation {
    condition = var.aws_instance_type=="t2.micro" || var.aws_instance_type=="t3.micro"
    error_message = "You gave wrong instance type"
  }
}

/*variable "root_volume_size" {
  description = "Give the root volume size!"
  type = number
  default = 20
}

variable "root_volume_type" {
  description = "Give the root volume type"
  type = string
  default = "gp2"
}*/

variable "ec2_config" {
  type = object({
    v_size = number
    v_type = string
  })
  
  default = {
    v_size = 20
    v_type = "gp2"
  }


}