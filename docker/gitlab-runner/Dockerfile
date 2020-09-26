FROM gitlab/gitlab-runner:v11.11.4

# 维护者
MAINTAINER zhaosh <sanhong_zhao@163.com>

# 制定用户组
USER root:root

# 修改apt源
RUN echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial main' > /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.aliyun.com/ubuntu/ xenial main' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main' >> /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial universe' >> /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.aliyun.com/ubuntu/ xenial universe' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe' >> /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates universe' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial-security main' >> /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial-security universe' >> /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security universe' >> /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get clean

# 安装Docker
RUN apt-get install -y openjdk-8-jdk && \
    apt-get install -y docker.io && \
    apt-get install -y docker-compose && \
    apt-get install -y maven

# Docker加速
RUN echo '{' > /etc/docker/daemon.json && \
    echo '       "registry-mirrors" : [' >> /etc/docker/daemon.json && \
    echo '          "https://rnxly1wc.mirror.aliyuncs.com",' >> /etc/docker/daemon.json && \
    echo '          "https://docker.mirrors.ustc.edu.cn",' >> /etc/docker/daemon.json && \
    echo '          "http://hub-mirror.c.163.com",' >> /etc/docker/daemon.json && \
    echo '          "http://registry.docker-cn.com"' >> /etc/docker/daemon.json && \
    echo '       ]' >> /etc/docker/daemon.json && \
    echo '}' >> /etc/docker/daemon.json

# 配置环境变量
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV MAVEN_HOME /usr/share/maven
ENV PATH $PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin

WORKDIR /
