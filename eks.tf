# EKS 集群与节点组

resource "aws_eks_cluster" "this" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.eks_version

  vpc_config {
    subnet_ids              = [
      aws_subnet.private_1.id,
      aws_subnet.private_2.id,
    ]
    endpoint_public_access  = true
    endpoint_private_access = false
    public_access_cidrs     = concat(var.eks_api_allowed_cidrs, [
      var.private_subnet_1_cidr,
      var.private_subnet_2_cidr
    ])
  }

  enabled_cluster_log_types = ["api", "authenticator"]

  tags = { Name = "${var.project_name}-eks-cluster" }
}

resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "default"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  scaling_config {
    min_size     = var.eks_node_min_size
    desired_size = var.eks_node_desired_size
    max_size     = var.eks_node_max_size
  }

  instance_types = [var.eks_node_instance_type]
  disk_size      = 20
  capacity_type  = "ON_DEMAND"

  tags = { Name = "${var.project_name}-eks-ng-default" }

  depends_on = [aws_iam_role_policy_attachment.node_worker, aws_iam_role_policy_attachment.node_cni, aws_iam_role_policy_attachment.node_ecr]
}

