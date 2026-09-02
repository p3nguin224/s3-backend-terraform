variable "aws_config_files" {
  type    = list(string)
  default = ["~/.aws/config"]
}

variable "aws_credentials_files" {
  type    = list(string)
  default = ["~/.aws/credentials"]
}

variable "aws_profile" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}
