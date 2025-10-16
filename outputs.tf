output "whoami" { value = data.aws_caller_identity.me.arn }

# VPC 输出
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "公网子网 ID 列表"
  value       = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "private_subnets" {
  description = "可出公网子网 ID 列表"
  value       = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

output "internal_subnets" {
  description = "纯内网子网 ID 列表"
  value       = [aws_subnet.internal_1.id, aws_subnet.internal_2.id]
}

output "s3_endpoint_id" {
  description = "S3 网关端点 ID"
  value       = aws_vpc_endpoint.s3_gateway.id
}

# =============== EKS 输出 ===============
output "eks_cluster_name" {
  value = aws_eks_cluster.this.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "eks_nodegroup_name" {
  value = aws_eks_node_group.default.node_group_name
}
