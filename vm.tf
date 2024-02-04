resource "aws_key_pair" "my_key"{
    key_name = "my_key"
    public_key = file("~/.ssh/my_key.pub")
}

resource "aws_instance" "my_ec2_server" {
  ami                    = "ami-0277155c3f0ab2930"
  instance_type          = "t2.micro"
  iam_instance_profile   = "LabInstanceProfile"
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  key_name               = aws_key_pair.my_key.key_name
  depends_on             = [aws_security_group.my-sg]
  tags = {
    Name  = "Assignment 1 - EC2"
    Owner = "Trupal"
  }
  user_data = file("install_docker.sh")
}

output "ec2_ip" {
  value = aws_instance.my_ec2_server.public_ip
}