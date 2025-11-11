terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # change as needed
}

# 🔹 Fetch the latest Amazon Linux 2023 AMI dynamically
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}


# 🔹 Create an EC2 instance using t3.micro
resource "aws_instance" "terraform_demo" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t3.micro"
subnet_id     = element(data.aws_subnet_ids.default.ids, 0)

  tags = {
    Name = "TerraformDemoInstance"
  }
}
