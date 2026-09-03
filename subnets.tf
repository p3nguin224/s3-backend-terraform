resource "aws_subnet" "dev-public-subnet-A" {
  vpc_id            = aws_vpc.dev-VCP-tokyo.id
  cidr_block        = var.public_subnet1_cidr_block
  availability_zone = "ap-northeast-1a"

  tags = {
    Name        = "dev-public-subnet-A"
    Environment = var.evnironment_name
    Region      = "tokyo"
  }
}

resource "aws_subnet" "dev-public-subnet-C" {
  vpc_id            = aws_vpc.dev-VCP-tokyo.id
  cidr_block        = var.public_subnet2_cidr_block
  availability_zone = "ap-northeast-1c"

  tags = {
    Name        = "dev-public-subnet-C"
    Environment = var.evnironment_name
    Region      = "tokyo"
  }
}

resource "aws_subnet" "dev-private-subnet-A" {
  vpc_id            = aws_vpc.dev-VCP-tokyo.id
  cidr_block        = var.private_subnet1_cidr_block
  availability_zone = "ap-northeast-1a"

  tags = {
    Name        = "dev-private-subnet-A"
    Environment = var.evnironment_name
    Region      = "tokyo"
  }
}
