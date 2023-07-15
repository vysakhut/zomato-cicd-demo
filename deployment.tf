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

resource "aws_instance" "git-webserver" {
  ami                    = "ami-0d13e3e640877b0b9"
  instance_type          = "t2.micro"
  key_name               = "mumbai-region"
  vpc_security_group_ids = [aws_security_group.zomato-webserver.id]
  user_data              = file("setup.sh")
  tags = {
    Name    = "${var.project_name}-${var.project_environment}-git-webserver"
    project = var.project_name
    env     = var.project_environment
  }
}
