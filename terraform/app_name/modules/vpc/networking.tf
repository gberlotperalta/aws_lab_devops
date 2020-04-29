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
  cidr_block = "${var.subnet_pub_cidr}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.app_name}pub_subnet"
    Environment = "${var.environment_tag}"
  }
}

#Create Subnet Private
resource "aws_subnet" "terra_pri_subnet" {
  vpc_id     = "${aws_vpc.terra_vpc.id}"
  cidr_block = "${var.subnet_pri_cidr}"

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

#Attach internet gateway to vpc
resource "aws_route" "vpc_internet_access" {
  route_table_id         = "${aws_route_table.terra_public_rt.id}"
  destination_cidr_block = "${var.destination_cidr_block}"
  gateway_id             = "${aws_internet_gateway.terra_ig.id}"
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

# Create Security Group, allow ingress for port 22 and 80
resource "aws_security_group" "terra_security_group" {
  vpc_id       = "${aws_vpc.terra_vpc.id}"
  
  # allow ingress of port 22
  ingress {
    cidr_blocks = ["0.0.0.0/0"]  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  } 
  
  # allow ingress of port 80
  ingress {
    cidr_blocks = ["0.0.0.0/0"]  
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  } 

  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

tags = {
    Name = "${var.app_name}security_group"
    Environment = "${var.environment_tag}"
  }

} 

# create VPC Network access control list
resource "aws_network_acl" "terra_nacl" {
  vpc_id = "${aws_vpc.terra_vpc.id}"
  subnet_ids = "[${aws_subnet.terra_pub_subnet.id}]"

# allow ingress port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.ingress_cidr_block}"
    from_port  = 22
    to_port    = 22
  }
  
  # allow ingress port 80 
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "${var.ingress_cidr_block}"
    from_port  = 80
    to_port    = 80
  }
  
  # allow ingress ephemeral ports 
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "${var.ingress_cidr_block}"
    from_port  = 1024
    to_port    = 65535
  }
  
  # allow egress port 22 
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.egress_cidr_block}"
    from_port  = 22 
    to_port    = 22
  }
  
  # allow egress port 80 
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "${var.egress_cidr_block}"
    from_port  = 80  
    to_port    = 80 
  }
 
  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "${var.egress_cidr_block}"
    from_port  = 1024
    to_port    = 65535
  }

tags = {
    Name = "${var.app_name}nacl"
    Environment = "${var.environment_tag}"
  }

} 


# OutPuts
output "terra_vpc_id" {
  value = "${aws_vpc.terra_vpc.id}"
}

output "terra_public_subnet_id" {
  value = "${aws_subnet.terra_pub_subnet.id}"
}

output "terra_private_subnet_id" {
  value = "${aws_subnet.terra_pri_subnet.id}"
}
