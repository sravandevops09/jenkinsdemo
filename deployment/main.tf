provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["342374577013"]
}

resource "aws_instance" "my_ec2" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t3.micro"

  tags = {
    Name = "AmazonLinux2023EC2"
  }
}

output "ami_id_used" {
  value = data.aws_ami.amazon_linux_2023.id
}
