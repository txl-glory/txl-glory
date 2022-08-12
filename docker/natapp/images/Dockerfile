# 基础镜像
FROM alpine

# 维护者
MAINTAINER txl

# 拷贝文件到容器
RUN mkdir /usr/local/share/natapp
ADD ./natapp /usr/local/share/natapp

# 文件授权
RUN chmod 755 /usr/local/share/natapp/natapp

#容器对外开放端口
EXPOSE 80

# 配置容器启动后执行的命令
ENTRYPOINT ["nohup", "/usr/local/share/natapp/natapp", "-authtoken=c5445b5", "-log=stdout", "-loglevel=ERROR", "&"]