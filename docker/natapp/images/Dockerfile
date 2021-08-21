# 基础镜像
FROM ubuntu:20.10

# 维护者
MAINTAINER txl

# 拷贝文件到容器
RUN mkdir /home/natapp
ADD ./natapp /home/natapp

# 进入目录
WORKDIR /home/natapp

# 文件授权
RUN chmod 755 /home/natapp

#容器对外开放端口
EXPOSE 80

# 配置容器启动后执行的命令
ENTRYPOINT ["nohup", "./natapp", "-authtoken=79ef517fefdfc1de", "-log=stdout", "-loglevel=ERROR", "&"]