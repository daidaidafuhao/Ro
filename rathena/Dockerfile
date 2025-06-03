FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y build-essential cmake git zlib1g-dev \
    libmariadb-dev libmariadb-dev-compat libpcre3-dev && \
    apt-get clean

WORKDIR /app

# 首先复制 CMakeLists.txt
COPY CMakeLists.txt ./

# 复制 src 目录
COPY src/ ./src/

# 确保 custom 目录存在
RUN mkdir -p src/custom

# 复制 custom 目录
COPY src/custom/ ./src/custom/

RUN mkdir build && cd build && cmake .. && make

CMD ["bash", "-c", "./athena-start start && tail -f /dev/null"] 