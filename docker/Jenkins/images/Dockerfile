# 基础镜像
FROM jenkins/jenkins:latest

# 镜像用户
USER root

# 复制node到容器
ADD ./node-v14.15.0-linux-x64 /usr/local/share

# 复制maven到容器
ADD ./apache-maven-3.6.3 /usr/local/share

# 置环境变量
ENV PATH=$PATH:/usr/local/share/node-v14.15.0-linux-x64/bin
ENV PATH=$PATH:/usr/local/share/apache-maven-3.6.3/bin

# 切换目录
WORKDIR /usr/local/share