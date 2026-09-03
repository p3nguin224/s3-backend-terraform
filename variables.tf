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
