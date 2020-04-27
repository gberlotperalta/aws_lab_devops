provider "aws" {
  region = "us-east-1"
  profile = "default"
}

module "my_vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  vpc_id      = "${module.my_vpc.vpc_id}"
  subnet1_cidr = "192.168.1.0/24"
  subnet2_cidr = "192.168.2.0/24"
}

module "my_ec2" {
  source        = "../modules/ec2"
  vpc_id      = "${module.my_vpc.vpc_id}"
  subnet_id     = "${module.my_vpc.public_subnet1_id}"
  ami_id        = "ami-085925f297f89fce1"
  instance_type = "t2.medium"
  
}
