# 变量定义

variable "aws_region" {
  description = "AWS区域"
  type        = string
  default     = "ap-northeast-1"
}

variable "project_name" {
  description = "项目名称，用于资源命名"
  type        = string
  default     = "prod-yesces"
}

variable "vpc_cidr" {
  description = "VPC的CIDR块"
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "公网子网1的CIDR块"
  type        = string
  default     = "10.1.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "公网子网2的CIDR块"
  type        = string
  default     = "10.1.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "可出公网子网1的CIDR块"
  type        = string
  default     = "10.1.10.0/24"
}

variable "private_subnet_2_cidr" {
  description = "可出公网子网2的CIDR块"
  type        = string
  default     = "10.1.11.0/24"
}

variable "internal_subnet_1_cidr" {
  description = "纯内网子网1的CIDR块"
  type        = string
  default     = "10.1.20.0/24"
}

variable "internal_subnet_2_cidr" {
  description = "纯内网子网2的CIDR块"
  type        = string
  default     = "10.1.21.0/24"
}

# ================= EKS 相关变量 =================
variable "eks_cluster_name" {
  description = "EKS 集群名称"
  type        = string
  default     = "prod-yesces-eks"
}

variable "eks_version" {
  description = "EKS 版本"
  type        = string
  default     = "1.30"
}

variable "eks_api_allowed_cidrs" {
  description = "允许访问 EKS 公网 API 的 CIDR 列表"
  type        = list(string)
  default     = ["16.163.175.148/32"]
}

variable "eks_node_instance_type" {
  description = "EKS 节点实例类型"
  type        = string
  default     = "t3.large" # 2 vCPU / 8 GiB
}

variable "eks_node_min_size" {
  description = "EKS 节点组最小节点数"
  type        = number
  default     = 0
}

variable "eks_node_desired_size" {
  description = "EKS 节点组期望节点数"
  type        = number
  default     = 0
}

variable "eks_node_max_size" {
  description = "EKS 节点组最大节点数"
  type        = number
  default     = 1
}
