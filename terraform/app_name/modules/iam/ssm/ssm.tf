resource "aws_iam_role_policy" "terra_ssm_policy" {
  name = "terra_ssm_policy"
  role = "${aws_iam_role.terra_ssm_role.id}"
  policy = "${file(policy.json)}"
}

resource "aws_iam_role" "terra_ssm_role" {
  name = "terra_ssm_role"
  assume_role_policy = "${var.assume_role_policy}"
}

resource "aws_iam_instance_profile" "terra_ssm_profile" {
  #Only Change this
  name = "terra_ssm_profile"
  role = "${aws_iam_role.terra_ssm_role.name}"
}

output "terra_iam_instance_profile_name_for_ssm" {
  value = "${aws_iam_instance_profile.terra_ssm_profile.name}"
}