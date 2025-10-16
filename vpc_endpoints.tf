# VPC 端点配置

# S3 网关端点
resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  
  route_table_ids = [
    aws_route_table.private.id,
    aws_route_table.internal.id
  ]
  
  tags = {
    Name = "${var.project_name}-s3-gw-endpoint"
  }
}
