
variable "assume_role_policy" {
  default = "${file(assume_role_policy.json)}"
}

 