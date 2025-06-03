FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y build-essential cmake git zlib1g-dev \
    libmariadb-dev libmariadb-dev-compat libpcre3-dev && \
    apt-get clean

WORKDIR /app

# 复制所有必要的文件
COPY . .

# 确保 custom 目录存在
RUN mkdir -p src/custom

RUN mkdir build && cd build && cmake .. && make

CMD ["bash", "-c", "./athena-start start && tail -f /dev/null"] 