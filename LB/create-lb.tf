resource "aws_lb" "TF_LB" {
  name               = "TF_LB"
  internal           = false
  load_balancer_type = "application"
  security_groups = [var.SEC-GR-TF]

  subnet_mapping {
    subnet_id = var.aws_subnet-public-SN
    allocation_id = aws_eip.example_eip.id
  }

  tags = {
    Name = "TF_LB"
  }
}

resource "aws_lb_target_group" "example_tg" {
  name_prefix = "example_tg_"
  port = 80
  protocol = "HTTP"
  vpc_id      = var.vpc-id
  target_type = "instance"
  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 3
    interval = 30
    timeout = 5
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "example_tg_attachment" {
  target_group_arn = aws_lb_target_group.example_tg.arn
  target_id        = var.ec2_instance
  port             = 80
}

resource "aws_lb_listener" "example_listener" {
  load_balancer_arn = aws_lb.example_lb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.example_tg.arn
  }
}