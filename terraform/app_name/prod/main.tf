provider "aws" {
  region = "us-east-1"
  profile = "default"
}

module "vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  vpc_id      = "${module.my_vpc.terra_vpc_id}"
  subnet1_cidr = "192.168.1.0/24"
  subnet2_cidr = "192.168.2.0/24"
}

module "ec2_jenkins" {
  source        = "../modules/ec2"
  subnet_id     = "${module.vpc.terra_public_subnet1_id}"
  #Use t3a.small cause got 2cpu and 2gb of ram and it's value is: 0,0188 USD per hour
  instance_type = "t3a.small"
  ami_id        = "ami-085925f297f89fce1"
  ec2_count     = 1
  #vpc_security_group_ids = [
  #  "${module.my_vpc.terra_sg_ssh_22_id}",
  #  "${module.my_vpc.terra_sg_http_80_id}"
  #  ]

  tags = {
    Name = "jenkins"
  }

}

module "ec2_docker_web" {
  source        = "../modules/ec2"
  subnet_id     = "${module.vpc.terra_public_subnet1_id}"
  
  #Use t3a.small cause got 2cpu and 2gb of ram and it's value is: 0,0188 USD per hour
  instance_type = "t3a.small"
  ami_id        = "ami-085925f297f89fce1"
  ec2_count     = 1
  #vpc_security_group_ids = [
  #  "${module.my_vpc.terra_sg_ssh_22_id}",
  #  "${module.my_vpc.terra_sg_http_80_id}"
  #  ]

  tags = {
    Name = "docker_web"
  }

}