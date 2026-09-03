resource "aws_vpc" "dev-VCP-tokyo" {
  cidr_block = var.vpc_cidr_block
  region     = var.aws_region

  tags = {
    Name        = "dev-VCP-tokyo"
    Environment = var.evnironment_name
    Region      = "tokyo"
  }
}
