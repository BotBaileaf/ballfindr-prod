resource "aws_lb" "tf-lb" {
  name               = "tf-lb"
  load_balancer_type = "application"
  security_groups = [var.SEC-GR-TF]
  subnets = var.aws_subnet-public-SN
  tags = {
    Name = "tf-lb"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.tf-lb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: Page not found :("
      status_code = 404
    }
  }
}

resource "aws_lb_target_group" "asg-tg" {
  name_prefix = "asg-tg"
  port = 80
  protocol = "HTTP"
  vpc_id      = var.vpc-id
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 30
    timeout = 5
    path = "/"
    protocol = "HTTP"
    matcher = "200"
  }
}

resource "aws_lb_listener_rule" "asg-listen" {
  listener_arn = aws_lb_listener.http.arn
  priority = 100
  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.asg-tg.arn
  }
}

