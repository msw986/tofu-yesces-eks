# IAM 与 OIDC/IRSA 配置

data "aws_iam_policy_document" "cluster_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name               = "${var.project_name}-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.cluster_assume.json

  tags = { Name = "${var.project_name}-eks-cluster-role" }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

data "aws_iam_policy_document" "node_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_node_role" {
  name               = "${var.project_name}-eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.node_assume.json
  tags = { Name = "${var.project_name}-eks-node-role" }
}

resource "aws_iam_role_policy_attachment" "node_worker" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "node_cni" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "node_ecr" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# ================= RDS 和 ElastiCache 权限策略 =================

# 创建自定义策略，包含RDS和ElastiCache权限
data "aws_iam_policy_document" "rds_elasticache_policy" {
  # RDS 权限
  statement {
    effect = "Allow"
    actions = [
      "rds:*",
      "rds-db:*"
    ]
    resources = ["*"]
  }
  
  # ElastiCache 权限
  statement {
    effect = "Allow"
    actions = [
      "elasticache:*"
    ]
    resources = ["*"]
  }
  
  # 标签权限
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:DescribeTags"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "rds_elasticache_policy" {
  name        = "${var.project_name}-rds-elasticache-policy"
  description = "Policy for RDS and ElastiCache operations"
  policy      = data.aws_iam_policy_document.rds_elasticache_policy.json

  tags = { Name = "${var.project_name}-rds-elasticache-policy" }
}

# 注意：这个策略需要手动附加到您的 opentofu 用户
# 或者您可以在AWS控制台中为 opentofu 用户添加以下权限：
# - AmazonRDSFullAccess
# - AmazonElastiCacheFullAccess

