# 基础镜像
FROM jenkinsci/jenkins:latest

# 镜像用户
USER root

# 拷贝EOS安装文件到容器
ADD ./node-v14.15.0-linux-x64 /home

# 置环境变量
ENV PATH=$PATH:/home/node-v14.15.0-linux-x64/bin

# 切换目录
WORKDIR /home