resource "aws_lb" "nginx_alb" {
  name                       = "${local.prefix}-lb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  enable_deletion_protection = false
  enable_http2 = true
  security_groups = [aws_security_group.alb_sg.id]
}


resource "aws_lb_target_group" "my_target_group" {
  name     = "${local.prefix}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_lb_target_group_attachment" "nginx_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.nginx_instance.id
}

resource "aws_alb_listener" "http_listener" {
  load_balancer_arn = aws_lb.nginx_alb.arn
    port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}
