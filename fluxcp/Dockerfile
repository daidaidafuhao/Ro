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

# 配置Apache - 允许.htaccess文件
RUN echo '<Directory /var/www/html>' > /etc/apache2/conf-available/flux.conf \
    && echo '    AllowOverride All' >> /etc/apache2/conf-available/flux.conf \
    && echo '    Require all granted' >> /etc/apache2/conf-available/flux.conf \
    && echo '</Directory>' >> /etc/apache2/conf-available/flux.conf \
    && a2enconf flux

# 确保index.php存在并有正确权限
RUN test -f /var/www/html/index.php && echo "index.php found" || echo "index.php missing" 