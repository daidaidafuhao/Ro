FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y build-essential cmake git zlib1g-dev \
    libmariadb-dev libmariadb-dev-compat libpcre3-dev && \
    apt-get clean

# 复制当前目录（包含CMakeLists.txt和所有源代码）到容器
COPY . /app/

WORKDIR /app


# 创建构建目录并编译
RUN mkdir -p build && \
    cd build && \
    echo -e "\033[1;33mRunning cmake...\033[0m" && \
    cmake .. && \
    echo -e "\033[1;33mStarting make with single thread for better error visibility...\033[0m" && \
    make VERBOSE=1

# 启动服务
CMD ["bash", "-c", "./athena-start start && tail -f /dev/null"] 