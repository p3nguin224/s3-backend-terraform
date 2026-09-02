resource "aws_vpc" "dev-VCP-tokyo" {
  cidr_block = "10.0.0.0/16"
  region     = "ap-northeast-1"

  tags = {
    Name        = "dev-VCP-tokyo"
    Environment = "dev"
    Region      = "tokyo"
  }
}
