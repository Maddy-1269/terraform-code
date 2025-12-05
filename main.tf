terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

#  Get latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#  Default VPC
data "aws_vpc" "default" {
  default = true
}

#  Default subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

locals {
  public_subnet_id = data.aws_subnets.default.ids[0]
}

#  Generate private key
resource "tls_private_key" "demo_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#  Save PEM file locally
resource "local_file" "demo_private_key_pem" {
  content              = tls_private_key.demo_key.private_key_pem
  filename             = "${path.module}/${var.key_pair_name}.pem"
  file_permission      = "0400"
  directory_permission = "0700"
}

#  Upload public key to AWS
resource "aws_key_pair" "demo_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.demo_key.public_key_openssh
}

#  Security Group allow SSH
resource "aws_security_group" "demo_sg" {
  name        = "demo-ssh-sg"
  description = "Allow SSH access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
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
    Name = "Demo-ssh-sg"
  }
}

#  EC2 Instance
resource "aws_instance" "demo_instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = local.public_subnet_id
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.demo_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}
