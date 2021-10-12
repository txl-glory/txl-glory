# 基础镜像
FROM ubuntu:20.10

# 维护者
MAINTAINER txl

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

# 安装环境
RUN apt-get install -y libicu66

# 执行命令
RUN mkdir /usr/local/share/fastgithub

# 拷贝文件到容器
ADD ./fastgithub_linux-x64-2.0.4 /usr/local/share/fastgithub

# 执行命令
RUN chown -R root:root /usr/local/share/fastgithub

# 进入目录
WORKDIR /usr/local/share/fastgithub

#容器对外开放端口
EXPOSE 38457

# 配置容器启动后执行的命令
ENTRYPOINT ["/usr/local/share/fastgithub/fastgithub"]