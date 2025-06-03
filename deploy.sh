#!/bin/bash

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 显示带颜色的消息
show_message() {
    echo -e "${2}${1}${NC}"
}

# 检查是否以root运行
if [ "$EUID" -ne 0 ]; then 
    show_message "请使用root权限运行此脚本" "$RED"
    exit 1
fi

# 创建备份目录
BACKUP_DIR="/backup/ro-server"
mkdir -p $BACKUP_DIR

# 备份数据库
backup_database() {
    show_message "开始备份数据库..." "$YELLOW"
    DATE=$(date +%Y%m%d_%H%M%S)
    docker compose exec mariadb mysqldump -u root -p${DB_ROOT_PASSWORD} ${DB_NAME} > ${BACKUP_DIR}/db_${DATE}.sql
    if [ $? -eq 0 ]; then
        show_message "数据库备份成功: ${BACKUP_DIR}/db_${DATE}.sql" "$GREEN"
    else
        show_message "数据库备份失败！" "$RED"
        exit 1
    fi
}

# 备份配置文件
backup_configs() {
    show_message "开始备份配置文件..." "$YELLOW"
    DATE=$(date +%Y%m%d_%H%M%S)
    tar -czf ${BACKUP_DIR}/configs_${DATE}.tar.gz ./rathena/conf
    if [ $? -eq 0 ]; then
        show_message "配置文件备份成功: ${BACKUP_DIR}/configs_${DATE}.tar.gz" "$GREEN"
    else
        show_message "配置文件备份失败！" "$RED"
        exit 1
    fi
}

# 清理旧备份（保留最近7天的备份）
cleanup_old_backups() {
    show_message "清理7天前的旧备份..." "$YELLOW"
    find ${BACKUP_DIR} -name "db_*.sql" -mtime +7 -delete
    find ${BACKUP_DIR} -name "configs_*.tar.gz" -mtime +7 -delete
    show_message "旧备份清理完成" "$GREEN"
}

# 更新代码
update_code() {
    show_message "开始更新代码..." "$YELLOW"
    git pull
    if [ $? -eq 0 ]; then
        show_message "代码更新成功" "$GREEN"
    else
        show_message "代码更新失败！" "$RED"
        exit 1
    fi
}

# 重启服务
restart_services() {
    show_message "重启服务..." "$YELLOW"
    docker compose down
    docker compose up -d --build
    if [ $? -eq 0 ]; then
        show_message "服务重启成功" "$GREEN"
    else
        show_message "服务重启失败！" "$RED"
        exit 1
    fi
}

# 检查服务状态
check_services() {
    show_message "检查服务状态..." "$YELLOW"
    docker compose ps
}

# 主菜单
show_menu() {
    echo "========================================="
    echo "        RO私服部署脚本 v1.0"
    echo "========================================="
    echo "1. 首次部署"
    echo "2. 更新代码并重启"
    echo "3. 仅备份数据"
    echo "4. 仅重启服务"
    echo "5. 查看服务状态"
    echo "6. 退出"
    echo "========================================="
    echo -n "请选择操作 [1-6]: "
}

# 首次部署
first_deploy() {
    show_message "开始首次部署..." "$YELLOW"
    
    # 检查必要文件
    if [ ! -f "docker-compose.yml" ] || [ ! -f ".env" ]; then
        show_message "缺少必要文件！" "$RED"
        exit 1
    fi
    
    # 创建必要目录
    mkdir -p rathena/conf rathena/logs
    
    # 启动服务
    docker compose up -d
    
    if [ $? -eq 0 ]; then
        show_message "首次部署成功！" "$GREEN"
        check_services
    else
        show_message "首次部署失败！" "$RED"
        exit 1
    fi
}

# 主循环
while true; do
    show_menu
    read choice
    
    case $choice in
        1)
            first_deploy
            ;;
        2)
            backup_database
            backup_configs
            update_code
            restart_services
            check_services
            ;;
        3)
            backup_database
            backup_configs
            cleanup_old_backups
            ;;
        4)
            restart_services
            check_services
            ;;
        5)
            check_services
            ;;
        6)
            show_message "再见！" "$GREEN"
            exit 0
            ;;
        *)
            show_message "无效的选择！" "$RED"
            ;;
    esac
    
    echo
    read -p "按回车键继续..."
done 