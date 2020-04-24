provider "aws" {
  region = "us-east-1"
  profile = "default"
}

module "my_vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  tenancy     = "default"
  vpc_id      = "${module.my_vpc.vpc_id}"
}

module "my_ec2" {
  source        = "../modules/ec2"
  ec2_count     = 1
  ami_id        = "ami-04b9e92b5572fa0d1"
  instance_type = "t2.micro"
  subnet_id     = "${module.my_vpc.subnet_id}"
}
