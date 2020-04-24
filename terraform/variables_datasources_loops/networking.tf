provider "aws" {
	region = "${var.region}"
}

resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"

  tags = {
    Name = "main"
	Location = "USA"
  }
}

resource "aws_subnet" "subnets" {
  count = "${length(data.aws_availability_zones.azs.names)}"	
  availability_zone = "${element(data.aws_availability_zones.azs.names, count.index)}"
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${element(var.subnet_cidr, count.index)}"
  #cidr_block = "190.160.${count.index+1}.0/24"

  tags = {
    Name = "Subnet-${count.index+1}"
  }
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}