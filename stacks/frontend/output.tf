output "lb_dns" {
  value = aws_lb.nginx_alb.dns_name
}