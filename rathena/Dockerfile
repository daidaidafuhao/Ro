FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y build-essential cmake git zlib1g-dev \
    libmariadb-dev libmariadb-dev-compat libpcre3-dev && \
    apt-get clean

# 复制app目录（包含完整的rAthena源代码）到容器
COPY app/ /app/

WORKDIR /app

# 设置脚本执行权限
RUN chmod +x athena-start

# 检查关键文件是否存在
RUN echo -e "\033[1;32mChecking project structure:\033[0m" && \
    ls -la && \
    echo -e "\033[1;32mChecking if CMakeLists.txt exists:\033[0m" && \
    ls -la CMakeLists.txt && \
    echo -e "\033[1;32mChecking athena-start permissions:\033[0m" && \
    ls -la athena-start && \
    echo -e "\033[1;32mChecking src subdirectory:\033[0m" && \
    ls -la src/ && \
    echo -e "\033[1;32mChecking src/custom directory:\033[0m" && \
    ls -la src/custom/ && \
    echo -e "\033[1;32mChecking src/custom/defines_pre.hpp:\033[0m" && \
    cat src/custom/defines_pre.hpp && \
    echo -e "\033[1;32mChecking src/custom/defines_post.hpp:\033[0m" && \
    cat src/custom/defines_post.hpp

# 创建构建目录并编译
RUN mkdir -p build && \
    cd build && \
    echo -e "\033[1;33mRunning cmake...\033[0m" && \
    cmake .. && \
    echo -e "\033[1;33mStarting make with reduced parallelism...\033[0m" && \
    make -j2

# 启动服务
CMD ["bash", "-c", "./athena-start start && tail -f /dev/null"] 