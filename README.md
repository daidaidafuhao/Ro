# RO私服 Docker 部署方案

这是一个使用 Docker 部署 RO 私服的完整解决方案，包含以下组件：

- rAthena 服务端
- MariaDB 数据库
- FluxCP 管理面板

## 目录结构

```
.
├── docker-compose.yml    # Docker 编排配置
├── .env                 # 环境变量配置
├── rathena/            # rAthena 服务端
│   └── Dockerfile
├── fluxcp/             # FluxCP 管理面板
│   └── Dockerfile
└── init-sql/           # 数据库初始化脚本
```

## 快速开始

1. 配置环境变量
   ```bash
   cp .env.example .env
   # 编辑 .env 文件，设置数据库密码等信息
   ```

2. 启动服务
   ```bash
   docker compose up -d
   ```

3. 访问管理面板
   - 打开浏览器访问 http://localhost:8080

## 服务说明

- rAthena 服务端：运行在容器内，无需暴露端口
- MariaDB 数据库：运行在容器内，数据持久化存储
- FluxCP 管理面板：通过 8080 端口访问

## 数据持久化

- 数据库数据存储在 Docker volume 中
- 配置文件挂载在 ./rathena/conf 目录
- 日志文件存储在 ./rathena/logs 目录

## 注意事项

1. 首次启动前请确保已正确配置 .env 文件
2. 数据库初始化脚本应放在 init-sql 目录下
3. 如需修改服务配置，请编辑相应的配置文件后重启容器 