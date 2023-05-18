terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

# Get latest ami-id
data "aws_ami" "aws-linux" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.0.20230503.0-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

# Create EC2 Instance
resource "aws_instance" "web" {
  ami           = data.aws_ami.aws-linux.id
  instance_type = "t2.micro"

  tags = {
    Name = "monitoring-app-jenkins-instance"
  }
}


output "instance_id" {
    value = aws_instance.web.id
  
}