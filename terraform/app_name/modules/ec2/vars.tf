
variable "ami_id" {
  default = "ami-085925f297f89fce1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_count" {
  default = "2"
}

variable "subnet_id" {}

variable "vpc_security_group_ids" {
  type = "list"
}
