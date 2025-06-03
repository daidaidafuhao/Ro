FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y build-essential cmake git zlib1g-dev \
    libmariadb-dev libmariadb-dev-compat libpcre3-dev && \
    apt-get clean

COPY src/ /app
WORKDIR /app

RUN mkdir build && cd build && cmake .. && make

CMD ["bash", "-c", "./athena-start start && tail -f /dev/null"] 