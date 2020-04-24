variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_ami" {
  type = "map"  
  
  default = {
    us-east-1 = "ami-062f7200baf2fa504"
	  us-west-2 = "ami-e251209a"
  }
}

