FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y build-essential cmake git zlib1g-dev \
    libmariadb-dev libmariadb-dev-compat libpcre3-dev && \
    apt-get clean

# 复制 src 目录到 /app
COPY src/ /app/

# 检查 custom 目录内容并以颜色输出
RUN echo -e "\033[1;32mContents of /app/custom:\033[0m" && ls -la /app/custom

WORKDIR /app

# 确保 custom 目录存在
RUN mkdir -p custom

RUN mkdir build && cd build && cmake .. && make

CMD ["bash", "-c", "./athena-start start && tail -f /dev/null"] 