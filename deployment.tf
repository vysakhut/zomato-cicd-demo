provider "aws" {}

variable "project_name" {
  default = "zomato"
}

variable "project_environment" {
  default = "prod"
}

resource "aws_security_group" "zomato-webserver" {
  name        = "${var.project_name}-${var.project_environment}-webserver"
  description = "Allow web traffic"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "${var.project_name}-${var.project_environment}-gitwebserver"
    project = var.project_name
    env     = var.project_environment
  }
}
