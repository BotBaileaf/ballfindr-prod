output "vpc-id" {
    value = aws_vpc.vpc-tf.id
}
output "aws_subnet-public-SN" {
    value = aws_subnet.public-SN.id
}
output "aws_subnet-private-SN" {
    value = aws_subnet.private-SN.id
}
output "alb_dns_name" {
    value = aws_lb.loadbalancer.dns_name
    description = "DNS name of LB"
}