# OpenTofu 主配置文件

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Provider 配置
provider "aws" {
  region  = var.aws_region     # 使用变量指定区域
  profile = "opentofu"         # 使用 ~/.aws/credentials 中的 profile
}

# 只读验证，不创建资源
data "aws_caller_identity" "me" {}
## whoami 输出已移至 outputs.tf
