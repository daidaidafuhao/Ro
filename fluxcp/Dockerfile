FROM php:8.1-apache

# 安装必要的PHP扩展
RUN docker-php-ext-install mysqli pdo pdo_mysql

# 复制源代码
COPY src/ /var/www/html/ 

# 创建必要的目录并设置权限
RUN mkdir -p /var/www/html/data/tmp \
    && mkdir -p /var/www/html/data/logs \
    && mkdir -p /var/www/html/data/schemas \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 777 /var/www/html/data

# 启用Apache mod_rewrite
RUN a2enmod rewrite

# 配置Apache - 创建完整的虚拟主机配置
RUN echo '<VirtualHost *:80>' > /etc/apache2/sites-available/000-default.conf \
    && echo '    ServerAdmin webmaster@localhost' >> /etc/apache2/sites-available/000-default.conf \
    && echo '    DocumentRoot /var/www/html' >> /etc/apache2/sites-available/000-default.conf \
    && echo '    DirectoryIndex index.php index.html' >> /etc/apache2/sites-available/000-default.conf \
    && echo '    <Directory /var/www/html>' >> /etc/apache2/sites-available/000-default.conf \
    && echo '        Options Indexes FollowSymLinks' >> /etc/apache2/sites-available/000-default.conf \
    && echo '        AllowOverride All' >> /etc/apache2/sites-available/000-default.conf \
    && echo '        Require all granted' >> /etc/apache2/sites-available/000-default.conf \
    && echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf \
    && echo '    ErrorLog ${APACHE_LOG_DIR}/error.log' >> /etc/apache2/sites-available/000-default.conf \
    && echo '    CustomLog ${APACHE_LOG_DIR}/access.log combined' >> /etc/apache2/sites-available/000-default.conf \
    && echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf

# 确保index.php存在并有正确权限
RUN test -f /var/www/html/index.php && echo "index.php found" || echo "index.php missing"

# 暴露端口
EXPOSE 80 