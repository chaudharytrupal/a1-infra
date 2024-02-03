terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default_vpc" {
    default = true
}

resource "aws_security_group" "my-sg" {
  name = "my-sg"
  vpc_id = data.aws_vpc.default_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
  Name = "my-sg"
 }
}

resource "aws_instance" "my_ec2_server" {
  ami             = "ami-0c7217cdde317cfec"
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  key_name        = "vockey"
  depends_on = [ aws_security_group.my-sg ]
  tags = {
    Name  = "Assignment 1 - EC2"
    Owner = "Trupal"
  }
}

output "ec2_ip" {
  value = aws_instance.my_ec2_server.public_ip
}

variable "repo_names" {
  default = ["my_db", "my_app"]
}

resource "aws_ecr_repository" "ecr_repos" {
  count                = length(var.repo_names)
  name                 = var.repo_names[count.index]

  image_scanning_configuration {
    scan_on_push = true
  }
}




