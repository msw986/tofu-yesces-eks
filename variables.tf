# 变量定义

variable "aws_region" {
  description = "AWS区域"
  type        = string
  default     = "ap-northeast-1"
}

variable "project_name" {
  description = "项目名称，用于资源命名"
  type        = string
  default     = "prod-yescex"
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
  default     = "prod-yescex-eks"
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
  default     = "t3.xlarge" # 4 vCPU / 16 GiB
}

variable "eks_node_min_size" {
  description = "EKS 节点组最小节点数"
  type        = number
  default     = 1
}

variable "eks_node_desired_size" {
  description = "EKS 节点组期望节点数"
  type        = number
  default     = 1
}

variable "eks_node_max_size" {
  description = "EKS 节点组最大节点数"
  type        = number
  default     = 1
}

# ================= RDS 相关变量 =================
variable "rds_instance_class" {
  description = "RDS 实例类型"
  type        = string
  default     = "db.t3.micro" # 最小规格
}

variable "rds_engine_version" {
  description = "MySQL 版本"
  type        = string
  default     = "5.7.44-rds.20250818"
}

variable "rds_allocated_storage" {
  description = "RDS 分配的存储空间 (GB)"
  type        = number
  default     = 20
}

variable "rds_database_name" {
  description = "RDS 数据库名称"
  type        = string
  default     = "appdb"
}

variable "rds_username" {
  description = "RDS 主用户名"
  type        = string
  default     = "admin"
}

variable "rds_password" {
  description = "RDS 主用户密码"
  type        = string
  sensitive   = true
  default     = "ChangeMe123!"
}

# ================= Redis 相关变量 =================
variable "redis_node_type" {
  description = "Redis 节点类型"
  type        = string
  default     = "cache.t3.micro" # 最小规格
}

variable "redis_engine_version" {
  description = "Redis 版本"
  type        = string
  default     = "7.x"
}

variable "redis_num_cache_nodes" {
  description = "Redis 缓存节点数量"
  type        = number
  default     = 1
}

variable "redis_parameter_group_name" {
  description = "Redis 参数组名称"
  type        = string
  default     = "default.redis7"
}
