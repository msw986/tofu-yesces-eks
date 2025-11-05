ls# Yescex 应用部署

## 应用项目位置
应用代码和Kubernetes部署文件位于独立项目中：
```
../yescex-apps/
```

## 当前可用应用

### PHP应用
- **位置**: `../yescex-apps/php-app/`
- **功能**: 测试RDS MySQL和Redis连接
- **部署**: 运行 `../yescex-apps/deploy-php-app.sh`

## 部署流程

1. **部署基础设施** (在当前tofu项目中):
   ```bash
   tofu apply
   ```

2. **部署应用** (在yescex-apps项目中):
   ```bash
   cd ../yescex-apps
   ./deploy-php-app.sh
   ```

## 获取应用访问地址
```bash
kubectl get service yescex-php-app-lb -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
```

## 项目结构说明
- **tofu项目**: 专门处理基础设施 (EKS, RDS, Redis, VPC等)
- **yescex-apps项目**: 专门处理应用部署 (PHP应用, K8s配置等)

这样的分离确保了：
- 基础设施和应用代码的清晰分离
- 独立的版本控制
- 更好的项目组织结构
