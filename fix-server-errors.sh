#!/bin/bash

echo "🔧 正在修复 rAthena 服务器错误..."

# 1. 创建必要的目录
echo "📁 创建缺失的目录..."
docker exec -it rathena-server bash -c "mkdir -p /opt/rathena/db/import"
docker exec -it rathena-server bash -c "mkdir -p /opt/rathena/conf/msg_conf/import"
docker exec -it rathena-server bash -c "mkdir -p /opt/rathena/conf/import"

# 2. 复制文件到容器
echo "📄 复制配置文件到容器..."
docker cp rathena/app/db/import/. rathena-server:/opt/rathena/db/import/
docker cp rathena/app/conf/msg_conf/import/. rathena-server:/opt/rathena/conf/msg_conf/import/

# 3. 应用数据库修复
echo "🗄️ 更新数据库用户..."
# 复制SQL文件到数据库容器
docker cp init-sql/03-create-server-users.sql rathena-db:/tmp/03-create-server-users.sql
# 执行SQL文件
docker exec -it rathena-db mysql -u root -p1999413wtic rathena -e "source /tmp/03-create-server-users.sql"

# 4. 重启服务
echo "🔄 重启服务..."
docker-compose restart rathena-server

echo "✅ 修复完成！"
echo ""
echo "🔍 主要修复内容："
echo "   ✓ 创建了缺失的 import 目录"
echo "   ✓ 创建了空的配置文件模板"
echo "   ✓ 修复了 s1/p1 默认用户问题"
echo "   ✓ 创建了安全的服务器间通信用户"
echo ""
echo "⚠️ 注意：root 权限警告仍然存在，这是正常的（容器内运行）" 