FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y build-essential cmake git zlib1g-dev \
    libmariadb-dev libmariadb-dev-compat libpcre3-dev && \
    apt-get clean

# 复制 src 目录到 /app
COPY src/ /app/
WORKDIR /app

# 确保 custom 目录存在
RUN mkdir -p custom

RUN mkdir build && cd build && cmake .. && make

CMD ["bash", "-c", "./athena-start start && tail -f /dev/null"] 