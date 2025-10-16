# EKS 核心 Add-ons

resource "aws_eks_addon" "vpc_cni" {
  cluster_name             = aws_eks_cluster.this.name
  addon_name               = "vpc-cni"
  resolve_conflicts_on_create = "OVERWRITE"
}

resource "aws_eks_addon" "coredns" {
  cluster_name             = aws_eks_cluster.this.name
  addon_name               = "coredns"
  resolve_conflicts_on_create = "OVERWRITE"
  depends_on = [aws_eks_node_group.default]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name             = aws_eks_cluster.this.name
  addon_name               = "kube-proxy"
  resolve_conflicts_on_create = "OVERWRITE"
}

# 如需 EBS CSI，可开启下方资源，并为其配置 IRSA 角色
# resource "aws_eks_addon" "ebs_csi" {
#   cluster_name = aws_eks_cluster.this.name
#   addon_name   = "aws-ebs-csi-driver"
# }

