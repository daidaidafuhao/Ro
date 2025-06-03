FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y build-essential cmake git zlib1g-dev \
    libmariadb-dev libmariadb-dev-compat libpcre3-dev && \
    apt-get clean

# 复制当前目录（包含CMakeLists.txt和所有源代码）到容器
COPY . /app/

WORKDIR /app

# 检查关键文件是否存在
RUN echo -e "\033[1;32mChecking project structure:\033[0m" && \
    ls -la && \
    echo -e "\033[1;32mChecking if CMakeLists.txt exists:\033[0m" && \
    ls -la CMakeLists.txt && \
    echo -e "\033[1;32mChecking src subdirectory:\033[0m" && \
    ls -la src/

# 创建custom目录并创建必要的头文件
RUN mkdir -p custom && \
    echo "// Copyright (c) rAthena Dev Teams - Licensed under GNU GPL" > custom/defines_pre.hpp && \
    echo "#ifndef CUSTOM_DEFINES_PRE_HPP" >> custom/defines_pre.hpp && \
    echo "#define CUSTOM_DEFINES_PRE_HPP" >> custom/defines_pre.hpp && \
    echo "" >> custom/defines_pre.hpp && \
    echo "// Custom pre-defines for rAthena" >> custom/defines_pre.hpp && \
    echo "// These defines are processed before all other configuration" >> custom/defines_pre.hpp && \
    echo "" >> custom/defines_pre.hpp && \
    echo "// Add any custom server configurations here" >> custom/defines_pre.hpp && \
    echo "" >> custom/defines_pre.hpp && \
    echo "#endif /* CUSTOM_DEFINES_PRE_HPP */" >> custom/defines_pre.hpp && \
    echo "// Copyright (c) rAthena Dev Teams - Licensed under GNU GPL" > custom/defines_post.hpp && \
    echo "#ifndef CUSTOM_DEFINES_POST_HPP" >> custom/defines_post.hpp && \
    echo "#define CUSTOM_DEFINES_POST_HPP" >> custom/defines_post.hpp && \
    echo "" >> custom/defines_post.hpp && \
    echo "// Custom post-defines for rAthena" >> custom/defines_post.hpp && \
    echo "// These defines are processed after all other configuration" >> custom/defines_post.hpp && \
    echo "" >> custom/defines_post.hpp && \
    echo "#endif /* CUSTOM_DEFINES_POST_HPP */" >> custom/defines_post.hpp

# 验证文件创建成功
RUN echo -e "\033[1;32mChecking custom directory:\033[0m" && \
    ls -la custom/ && \
    echo -e "\033[1;32mChecking defines_pre.hpp:\033[0m" && \
    cat custom/defines_pre.hpp && \
    echo -e "\033[1;32mChecking defines_post.hpp:\033[0m" && \
    cat custom/defines_post.hpp

# 创建构建目录并编译
RUN mkdir -p build && \
    cd build && \
    echo -e "\033[1;33mRunning cmake...\033[0m" && \
    cmake .. && \
    echo -e "\033[1;33mStarting make with single thread for better error visibility...\033[0m" && \
    make VERBOSE=1

# 启动服务
CMD ["bash", "-c", "./athena-start start && tail -f /dev/null"] 