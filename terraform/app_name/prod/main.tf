provider "aws" {
  region = "us-east-1"
  profile = "default"
}

module "my_vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  vpc_id      = "${module.my_vpc.id}"
  subnet_cidr = "192.168.1.0/24"
}

module "my_ec2" {
  source        = "../modules/ec2"
  vpc_id      = "${module.my_vpc.id}"
  subnet_id     = "${module.my_vpc.subnet_id}"
  ami_id        = "ami-5a8da735"
  instance_type = "t2.micro"
  
}
