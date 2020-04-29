
variable "app_name" {
  default = "terra_webapp_"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_id" {}

variable "subnet_pub_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet_pri_cidr" {
  default = "10.0.2.0/24"
}

variable "destination_cidr_block" {
  default = "0.0.0.0/0"
}

variable "environment_tag" {
  default = "Production"
}