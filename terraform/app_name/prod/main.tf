provider "aws" {
  region = "us-east-1"
  profile = "default"
}

module "my_vpc" {
  source      = "../modules/vpc"
  ec2_count     = 1
  vpc_cidr    = "192.168.0.0/16"
  vpc_id      = "${module.my_vpc.terra_vpc_id}"
  subnet1_cidr = "192.168.1.0/24"
  subnet2_cidr = "192.168.2.0/24"
}

module "my_ec2_jenkins" {
  source        = "../modules/ec2"
  subnet_id     = "${module.my_vpc.terra_public_subnet1_id}"
  ami_id        = "ami-085925f297f89fce1"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${module.my_vpc.terra_sg_ssh_22_id}"]
  
}
