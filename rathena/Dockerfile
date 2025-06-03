FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y build-essential cmake git zlib1g-dev \
    libmariadb-dev libmariadb-dev-compat libpcre3-dev && \
    apt-get clean

# 复制src目录（包含CMakeLists.txt和源代码）到容器
COPY src/ /app/

WORKDIR /app

# 检查关键文件是否存在
RUN echo -e "\033[1;32mChecking project structure:\033[0m" && \
    ls -la && \
    echo -e "\033[1;32mChecking custom directory:\033[0m" && \
    ls -la custom/ && \
    echo -e "\033[1;32mChecking defines_pre.hpp:\033[0m" && \
    cat custom/defines_pre.hpp && \
    echo -e "\033[1;32mChecking src subdirectory:\033[0m" && \
    ls -la src/

# 创建构建目录并编译（减少并行度避免内存问题）
RUN mkdir -p build && \
    cd build && \
    echo -e "\033[1;33mRunning cmake...\033[0m" && \
    cmake .. && \
    echo -e "\033[1;33mStarting make with reduced parallelism...\033[0m" && \
    make -j2 VERBOSE=1

# 启动服务
CMD ["bash", "-c", "./athena-start start && tail -f /dev/null"] 