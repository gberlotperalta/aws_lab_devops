provider "aws" {
  region = "us-east-1"
  profile = "default"
}

module "vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = "10.0.0.0/16"
  vpc_id      = "${module.vpc.terra_vpc_id}"
  subnet_pub_cidr = "10.0.1.0/24"
  subnet_pri_cidr = "10.0.2.0/24"
}

module "ec2_jenkins" {
  source        = "../modules/ec2"
  subnet_id     = "${module.vpc.terra_public_subnet_id}"
  #Use t3a.small cause got 2cpu and 2gb of ram and it's value is: 0,0188 USD per hour
  instance_type = "t2.micro"
  ami_id        = "ami-085925f297f89fce1"
  ec2_count     = 1
  key_name      = "G1B4"
  associate_public_ip_address = true
  source_dest_check = false
  vpc_security_group_ids = ["${module.vpc.terra_security_group_web_id}"] 
  tags = {
    Name = "jenkins"
  }
}