variable "aws_config_files" {
  description = "AWS config file path"
  type        = list(string)
  default     = ["~/.aws/config"]
}

variable "aws_credentials_files" {
  description = "AWS credentials file path"
  type        = list(string)
  default     = ["~/.aws/credentials"]
}

variable "aws_profile" {
  description = "AWS profile name"
  type        = string
}

variable "aws_region" {
  description = "AWS region. Default is ap-northeast-1."
  type        = string
  default     = "ap-northeast-1"
}

variable "aws_ec2_keypairname" {
  description = "Name of keypair for EC2 instance"
  type        = string
}

variable "ssh_open_ip" {
  description = "Address to allow SSH for bastion Host"
  type        = string
}


variable "vpc_cidr_block" {
  description = "CIRD range for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "evnironment_name" {
  description = "Environment name"
  type        = string
}

variable "public_subnet1_cidr_block" {
  description = "CIRD range for public subnet 1"
  type        = string
}

variable "public_subnet2_cidr_block" {
  description = "CIRD range for public subnet 2"
  type        = string
}

variable "private_subnet1_cidr_block" {
  description = "CIRD range for private subnet 1"
  type        = string
}

variable "ec2_instance_type" {
  description = "Type of both EC2 instances. Default is t3.micro"
  type        = string
  default     = "t3.micro"
}
