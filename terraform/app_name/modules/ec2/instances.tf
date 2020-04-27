resource "aws_instance" "jenkins" {
  vpc_id = "${var.vpc_id}"
  subnet_id     = "${var.subnet_id}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  tags = {
    Name = "Jenkins"
  }
}

#Create IAM Roles

#Create Security Group for Jenkins


#Create Security Group for Web Users