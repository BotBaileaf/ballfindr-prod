output "vpc-id" {
    value = aws_vpc.vpc-tf.id
}
output "aws_subnet-public-SN" {
    value = aws_subnet.public-SN.id
}
output "aws_subnet-public-SN-2" {
    value = aws_subnet.public-SN-2.id
}
output "aws_subnet-private-SN" {
    value = aws_subnet.private-SN.id
}
