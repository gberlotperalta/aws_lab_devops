resource "aws_iam_role_policy" "terra_s3_policy" {
  name = "terra_s3_policy"
  role = "${aws_iam_role.terra_s3_role.id}"
  policy = "${file(s3-policy.json)}"
}

resource "aws_iam_role" "terra_s3_role" {
  name = "terra_s3_role"
  assume_role_policy = "${file(s3-assume_role_policy.json)}"
}

resource "aws_iam_instance_profile" "terra_s3_profile" {
  name = "terra_s3_profile"
  role = "${aws_iam_role.terra_s3_role.name}"
}

output "terra_iam_instance_profile_name_for_s3" {
  value = "${aws_iam_instance_profile.terra_s3_profile.name}"
}