
#Public Instances
resource "aws_instance" "ec2server" {
  subnet_id     = "${var.subnet_id}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  count         = "${var.ec2_count}"
  key_name      = "${var.key_name}"
}


#Private Instances 
#Create IAM Roles




