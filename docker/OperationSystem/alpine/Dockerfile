#基础镜像
FROM alpine

#作者
MAINTAINER TXL

#设置时区
ADD /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo Asia/Shanghai > /etc/timezone

#换阿里源并更新
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update && apk upgrade

#定义环境变量
ENV WORK_HOME /

#设置进入容器后的主目录
WORKDIR $WORK_HOME

#安装jdk8
RUN apk add openjdk8