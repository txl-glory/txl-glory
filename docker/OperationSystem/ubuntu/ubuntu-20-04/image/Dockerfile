# 基础镜像
FROM ubuntu:24.04

# 维护者
MAINTAINER zhaosh

# 设置用户组
USER root:root

# 修改apt源
RUN echo 'deb https://mirrors.aliyun.com/ubuntu/ noble main restricted universe multiverse' > /etc/apt/sources.list && \
    echo 'deb-src https://mirrors.aliyun.com/ubuntu/ noble main restricted universe multiverse' > /etc/apt/sources.list && \
    echo 'deb https://mirrors.aliyun.com/ubuntu/ noble-security main restricted universe multiverse' > /etc/apt/sources.list && \
    echo 'deb-src https://mirrors.aliyun.com/ubuntu/ noble-security main restricted universe multiverse' > /etc/apt/sources.list && \
    echo 'deb https://mirrors.aliyun.com/ubuntu/ noble-updates main restricted universe multiverse' > /etc/apt/sources.list && \
    echo 'deb-src https://mirrors.aliyun.com/ubuntu/ noble-updates main restricted universe multiverse' > /etc/apt/sources.list && \
    echo 'deb https://mirrors.aliyun.com/ubuntu/ noble-backports main restricted universe multiverse' > /etc/apt/sources.list && \
    echo 'deb-src https://mirrors.aliyun.com/ubuntu/ noble-backports main restricted universe multiverse' > /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get clean

# 安装环境
RUN apt-get install -y libicu66

# 执行命令
RUN mkdir /usr/local/share/fastgithub

# 拷贝文件到容器
ADD ./fastgithub_linux-x64-2.1.2 /usr/local/share/fastgithub

# 执行命令
RUN chown -R root:root /usr/local/share/fastgithub

# 进入目录
WORKDIR /usr/local/share/fastgithub

#容器对外开放端口
EXPOSE 38457

# 配置容器启动后执行的命令
ENTRYPOINT ["/usr/local/share/fastgithub/fastgithub"]