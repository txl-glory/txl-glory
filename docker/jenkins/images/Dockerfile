# 基础镜像
FROM jenkins/jenkins:latest

# 镜像用户
USER root

# 修改apt源
RUN echo 'deb https://mirrors.aliyun.com/debian/ bullseye main non-free contrib' > /etc/apt/sources.list && \
    echo 'deb-src https://mirrors.aliyun.com/debian/ bullseye main non-free contrib' > /etc/apt/sources.list && \
    echo 'deb https://mirrors.aliyun.com/debian-security/ bullseye-security main' > /etc/apt/sources.list && \
    echo 'deb-src https://mirrors.aliyun.com/debian-security/ bullseye-security main' > /etc/apt/sources.list && \
    echo 'deb https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib' > /etc/apt/sources.list && \
    echo 'deb-src https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib' > /etc/apt/sources.list && \
    echo 'deb https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib' > /etc/apt/sources.list && \
    echo 'deb-src https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib' > /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get clean

# 安装依赖
RUN apt-get install -y p7zip-full curl

# 安装nvm
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

RUN nvm install v14.21.3

# 切换目录
WORKDIR /usr/local/share
