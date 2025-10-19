# IAM权限配置说明

## 问题描述
当前IAM用户 `opentofu` 缺少RDS和ElastiCache的权限，导致部署失败。

## 解决方案

### 方案1：在AWS控制台中手动添加权限（推荐）

1. 登录AWS控制台
2. 进入IAM服务
3. 找到用户 `opentofu`
4. 点击"添加权限" → "直接附加现有策略"
5. 搜索并添加以下策略：
   - `AmazonRDSFullAccess`
   - `AmazonElastiCacheFullAccess`

### 方案2：使用AWS CLI添加权限

```bash
# 为opentofu用户添加RDS权限
aws iam attach-user-policy \
    --user-name opentofu \
    --policy-arn arn:aws:iam::aws:policy/AmazonRDSFullAccess

# 为opentofu用户添加ElastiCache权限
aws iam attach-user-policy \
    --user-name opentofu \
    --policy-arn arn:aws:iam::aws:policy/AmazonElastiCacheFullAccess
```

### 方案3：使用Terraform创建并附加策略

如果您有管理员权限，可以运行以下命令创建策略并附加到用户：

```bash
# 先应用IAM策略
tofu apply -target=aws_iam_policy.rds_elasticache_policy

# 然后手动在AWS控制台中将策略附加到opentofu用户
```

## 验证权限

添加权限后，可以运行以下命令验证：

```bash
# 测试RDS权限
aws rds describe-db-instances --region ap-northeast-1

# 测试ElastiCache权限
aws elasticache describe-cache-clusters --region ap-northeast-1
```

## 重新部署

权限配置完成后，重新运行：

```bash
tofu apply
```

## 注意事项

- 确保您的AWS凭证配置正确
- 如果使用AWS CLI，确保有足够的权限修改IAM策略
- 建议在生产环境中使用最小权限原则，只授予必要的权限
