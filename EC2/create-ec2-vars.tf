variable "aws_subnet-public-SN" {}
variable "aws_subnet-public-SN-2" {}
variable "aws_subnet-private-SN" {}
variable "SEC-GR-TF" {}
variable "asg-tg" {}
variable "chassis" {
    type = string
    default = "t2.micro"
}