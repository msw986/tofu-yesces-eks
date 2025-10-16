# 网关和 NAT 配置

# 互联网网关
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.project_name}-igw"
  }
}

# NAT 网关的弹性 IP
resource "aws_eip" "nat" {
  domain = "vpc"
  
  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

# NAT 网关
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1.id
  
  tags = {
    Name = "${var.project_name}-nat"
  }
  
  depends_on = [aws_internet_gateway.igw]
}

# 公网路由表
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# 公网路由 - 指向互联网网关
resource "aws_route" "public_inet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# 公网子网路由表关联
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

# 可出公网路由表
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

# 可出公网路由 - 指向 NAT 网关
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# 可出公网子网路由表关联
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}

# 纯内网路由表
resource "aws_route_table" "internal" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.project_name}-internal-rt"
  }
}

# 纯内网子网路由表关联
resource "aws_route_table_association" "internal_1" {
  subnet_id      = aws_subnet.internal_1.id
  route_table_id = aws_route_table.internal.id
}

resource "aws_route_table_association" "internal_2" {
  subnet_id      = aws_subnet.internal_2.id
  route_table_id = aws_route_table.internal.id
}
