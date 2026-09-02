# SUBNET CREATION
resource "aws_vpc" "dev-VCP-tokyo" {
  cidr_block = "10.0.0.0/16"
  region     = "ap-northeast-1"

  tags = {
    Name        = "dev-VCP-tokyo"
    Environment = "dev"
    Region      = "tokyo"
  }
}

resource "aws_subnet" "dev-public-subnet-A" {
  vpc_id            = aws_vpc.dev-VCP-tokyo.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name        = "dev-public-subnet-A"
    Environment = "dev"
    Region      = "tokyo"
  }
}

resource "aws_subnet" "dev-public-subnet-C" {
  vpc_id            = aws_vpc.dev-VCP-tokyo.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name        = "dev-public-subnet-C"
    Environment = "dev"
    Region      = "tokyo"
  }
}

resource "aws_subnet" "dev-private-subnet-A" {
  vpc_id            = aws_vpc.dev-VCP-tokyo.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name        = "dev-private-subnet-A"
    Environment = "dev"
    Region      = "tokyo"
  }
}
