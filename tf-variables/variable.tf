variable "aws_instance_type" {
  description = "Give the instance type name for Instance!"
  type = string
  validation {
    condition = var.aws_instance_type=="t2.micro" || var.aws_instance_type=="t3.micro"
    error_message = "You gave wrong instance type"
  }
}

variable "root_volume_size" {
  description = "Give the Volume size!"
  type = number
  default = 20
}