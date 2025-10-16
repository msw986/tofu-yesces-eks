# VPC 和子网定义

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# 获取可用区信息
data "aws_availability_zones" "available" {
  state = "available"
}

# 公网子网 1
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.project_name}-public-1"
    Tier = "public"
  }
}

# 公网子网 2
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.project_name}-public-2"
    Tier = "public"
  }
}

# 可出公网子网 1
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  
  tags = {
    Name = "${var.project_name}-private-1"
    Tier = "private"
  }
}

# 可出公网子网 2
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  
  tags = {
    Name = "${var.project_name}-private-2"
    Tier = "private"
  }
}

# 纯内网子网 1
resource "aws_subnet" "internal_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.internal_subnet_1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  
  tags = {
    Name = "${var.project_name}-internal-1"
    Tier = "internal"
  }
}

# 纯内网子网 2
resource "aws_subnet" "internal_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.internal_subnet_2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  
  tags = {
    Name = "${var.project_name}-internal-2"
    Tier = "internal"
  }
}
