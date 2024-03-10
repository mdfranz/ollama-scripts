variable "aws_region" {
  default = "us-east-1"
}

variable "aws_vpcid" {}
variable "aws_subnet_a" {}
variable "ssh_publickey" {
  default = "/home/ubuntu/.ssh/id_rsa.pub"
}
