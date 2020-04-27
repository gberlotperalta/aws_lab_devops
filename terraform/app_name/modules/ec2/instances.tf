
#Public Instances
resource "aws_instance" "jenkins" {
  subnet_id     = "${var.subnet_id}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  count         = "${var.ec2_count}"
  vpc_security_group_ids = ["${aws_security_group.terra_sg_ssh_22.id}","${aws_security_group.terra_sg_http_80.id}"]

  tags = {
    Name = "Jenkins"
  }
}


#Private Instances 
#Create IAM Roles

#Security Groups for SSH
resource "aws_security_group" "terra_sg_ssh_22" {
  vpc_id = "${var.vpc_id}"

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
  }
}


#Security Group for Web App

resource "aws_security_group" "terra_sg_http_80" {
  vpc_id = "${var.vpc_id}"

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
  }
}



