
#Public Instances
resource "aws_instance" "jenkins" {
  subnet_id     = "${var.subnet_id}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  count         = "${var.ec2_count}"
  
  tags = {
    Name = "Jenkins"
  }
}


#Private Instances 
#Create IAM Roles




