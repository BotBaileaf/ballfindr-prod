output "asg-tg" {
    value = aws_lb_target_group.asg-tg
}
output "alb_dns_name" {
    value = aws_lb.loadbalancer.dns_name
    description = "DNS name of LB"
}