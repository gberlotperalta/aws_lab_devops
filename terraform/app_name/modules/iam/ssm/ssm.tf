data "template_file" "policy" {
  template = "${file("${path.module}/policy.json")}"
}

resource "aws_iam_role_policy" "terra_ssm_policy" {
  name = "terra_ssm_policy"
  role = "${aws_iam_role.terra_ssm_role.id}"
  policy = "${data.template_file.policy.rendered}"
}

data "template_file" "assume-role-policy" {
  template = "${file("${path.module}/assume_role_policy.json")}"
}

resource "aws_iam_role" "terra_ssm_role" {
  name = "terra_ssm_role"
  assume_role_policy = "${data.template_file.assume-role-policy.rendered}"
}

resource "aws_iam_instance_profile" "terra_ssm_profile" {
  #Only Change this
  name = "terra_ssm_profile"
  role = "${aws_iam_role.terra_ssm_role.name}"
}