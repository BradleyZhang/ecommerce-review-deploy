Ecommerce Review Service

电商评论微服务
---

项目包含以下微服务：

| 服务	| 说明	| HTTP	| gRPC |
| ---- | --- | --- | --- |
| review-service	| 评论核心业务服务	| 8085	| 9095 | 
| review-b	| 评论业务服务 B	| 8086	| 9096 |
| review-o	| 评论业务服务 O	| 8087	| 9097 |

部署

Docker Compose
```bash
# 下载项目源码
git clone https://github.com/BradleyZhang/ecommerce-review-deploy

# 进入项目目录
cd ecommerce-review-deploy

git submodule update --init --recursive   # 拉取子模块
cp .env.example .env                      # 填写 ES 地址、密码等
# 根据需要编辑 docker-compose.yml 文件
nano docker-compose.yml

docker compose up -d --build
```

consul 面板: `http://localhost:8500`