resource "aws_instance" "nginx_instance" {
  ami                    = var.nginx_ami_id
  instance_type          = var.instance_type
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "nginx-instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              service httpd start
              chkconfig httpd on
              echo "Hello, this is the default Apache page!" > /var/www/html/index.html
              EOF

  depends_on = [aws_lb_target_group.my_target_group]
}

