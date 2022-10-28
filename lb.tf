resource "aws_lb" "external-lb" {
  name            = "External-LB"
  internal        = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.web-sg.id]
  subnets         = [aws_subnet.web-sub-1.id, aws_subnet.web-sub-2.id]
}

resource "aws_lb_target_group" "external-elb" {
  name            = "ALB-TG"
  port            = 80
  protocol        = "HTTP"
  vpc_id          = aws_vpc.web-app-vpc.id
}

resource "aws_lb_target_group_attachment" "external-elb1" {
  target_group_arn  = aws_lb_target_group.external-elb.arn
  target_id         = aws_instance.webserver-1.id
  port              = 80

  depends_on        = [
    aws_instance.webserver-1
  ]
}

resource "aws_lb_target_group_attachment" "external-elb1" {
  target_group_arn  = aws_lb_target_group.external-elb.arn
  target_id         = aws_instance.webserver-2.id
  port              = 80

  depends_on        = [
    aws_instance.webserver-2
  ]
}

resource "aws_lb_listener" "external-elb-list" {
  load_balancer_arn   = aws_lb.external-lb.arn
  port                = 80
  protocol            = "HTTP"
  default_action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.external-elb.arn
  }
}