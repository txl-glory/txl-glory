# 基础镜像
FROM ubuntu:20.04

# 维护者
MAINTAINER TXL

# 设置用户组
USER root:root

# 修改apt源
RUN echo 'deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse' > /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse' >> /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get clean

# 安装jdk环境
RUN apt-get install openjdk-8-jdk -y

# 执行命令
RUN mkdir /home/eladmin

# 拷贝文件到容器
ADD ./eladmin-system-2.6.jar /home/eladmin
ADD ./upload /home/eladmin

# 切换工作目录
WORKDIR /home/eladmin

# 设置java运行环境
ENV JAVA_OPTS="-Xms512m -Xmx1024m"
ENV TZ="Asia/Shanghai"

# 默认端口开放
EXPOSE 8000

# 配置容器启动后执行的命令
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","-Dspring.profiles.active=citic177","/home/eladmin/eladmin-system-2.6.jar"]