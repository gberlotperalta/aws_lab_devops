#Create VPC
resource "aws_vpc" "terra_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.app_name}vpc"
    Environment = "${var.environment_tag}"
  }
}

#Create Subnet Public
resource "aws_subnet" "terra_pub_subnet" {
  vpc_id     = "${aws_vpc.terra_vpc.id}"
  cidr_block = "${var.subnet1_cidr}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.app_name}pub_subnet"
    Environment = "${var.environment_tag}"
  }
}

#Create Subnet Private
resource "aws_subnet" "terra_pri_subnet" {
  vpc_id     = "${aws_vpc.terra_vpc.id}"
  cidr_block = "${var.subnet2_cidr}"

  tags = {
    Name = "${var.app_name}pri_subnet"
    Environment = "${var.environment_tag}"
  }
}

#Create internet Gateway
resource "aws_internet_gateway" "terra_ig" {
  vpc_id = "${aws_vpc.terra_vpc.id}"
  tags = {
    Name = "${var.app_name}internet_gateway"
    Environment = "${var.environment_tag}"
  }
}

#Attach internet gateway to vpc
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.terra_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.terra_ig.id}"
}

#Create public route table
resource "aws_route_table" "terra_public_rt" {
  vpc_id = "${aws_vpc.terra_vpc.id}"

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = "${aws_internet_gateway.terra_ig.id}"
  }

  tags = {
    Name = "${var.app_name}public_rt"
    Environment = "${var.environment_tag}"
  }
}

#Create private route table
resource "aws_route_table" "terra_private_rt" {
  vpc_id = "${aws_vpc.terra_vpc.id}"

  tags = {
    Name = "${var.app_name}private_rt"
    Environment = "${var.environment_tag}"
  }
}

# Route table association with public subnets
resource "aws_route_table_association" "rt_aso_pub" {
  subnet_id      = "${aws_subnet.terra_pub_subnet.id}"
  route_table_id = "${aws_route_table.terra_public_rt.id}"
}

# Route table association with private subnets
resource "aws_route_table_association" "rt_aso_pri" {
  subnet_id      = "${aws_subnet.terra_pri_subnet.id}"
  route_table_id = "${aws_route_table.terra_private_rt.id}"
}


#Security Groups for SSH (port 22)
resource "aws_security_group" "terra_sg_ssh_22" {
  vpc_id = "${aws_vpc.terra_vpc.id}"

  # SSH access from the VPC
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terra_sg_ssh_22"
    Environment = "${var.environment_tag}"
  }
}

#Security Group for Web App (port 80)
resource "aws_security_group" "terra_sg_http_80" {
  vpc_id = "${aws_vpc.terra_vpc.id}"

  # Http access from web
  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terra_sg_http_80"
    Environment = "${var.environment_tag}"
  }
}



# When everything is running create NACL

output "terra_vpc_id" {
  value = "${aws_vpc.terra_vpc.id}"
}

output "terra_public_subnet1_id" {
  value = "${aws_subnet.terra_pub_subnet.id}"
}

output "terra_private_subnet2_id" {
  value = "${aws_subnet.terra_pri_subnet.id}"
}

output "terra_sg_ssh_22_id" {
  value = "${aws_security_group.terra_sg_ssh_22.id}"
}

output "terra_sg_http_80_id" {
  value = "${aws_security_group.terra_sg_http_80.id}"
}