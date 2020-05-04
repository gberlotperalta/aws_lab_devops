resource "aws_iam_role_policy" "terra_ec2_policy" {
  name = "terra_ec2_policy"
  role = "${aws_iam_role.terra_ec2_role.id}"
  policy = "${file(ec2-policy.json)}"
}

resource "aws_iam_role" "terra_ec2_role" {
  name = "terra_ec2_role"
  assume_role_policy = "${file(ec2-assume_role_policy.json)}"
}

resource "aws_iam_instance_profile" "terra_ec2_profile" {
  name = "terra_ec2_profile"
  role = "${aws_iam_role.terra_ec2_role.name}"
}

output "terra_iam_instance_profile_name_for_ec2" {
  value = "${aws_iam_instance_profile.terra_ec2_profile.name}"
}