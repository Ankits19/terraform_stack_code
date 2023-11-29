###############################
## Load Balancer Security group
###############################
resource "aws_security_group" "alb_sg" {
  name        = "${local.prefix}-alb-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  description = "Allow HTTP traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#########################
##Instance Security group
#########################

resource "aws_security_group" "ec2_sg" {
  name        = "${local.prefix}-ec2-sg"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  description = "Allow HTTP traffic"
}


resource "aws_security_group_rule" "http_from_lb" {
  security_group_id        = aws_security_group.ec2_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "egress_to_internet" {
  security_group_id = aws_security_group.ec2_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}