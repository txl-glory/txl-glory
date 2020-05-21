# 基础镜像
FROM tomcat:8.5.55-jdk8

# 维护者
MAINTAINER txl

# 拷贝EOS安装文件到容器
ADD ./EOS_Platform_7.6_Enterprise_Edition_Linux /home/primeton-eos

# 进入EOS安装目录
WORKDIR /home/primeton-eos

# EOS安装文件授权
RUN chown -R root:root /home/primeton-eos
RUN chmod 755 /home/primeton-eos/install.sh

# 执行安装脚本
RUN ["/home/primeton-eos/install.sh","-silent"]

# 进入EOS主目录
WORKDIR /usr/local/primeton

# 删除EOS安装文件
RUN rm -rf /home/primeton-eos

#容器对外开放端口
EXPOSE 8080 6200 6299

# 设置java运行环境
ENV JAVA_OPTS="-Xms512m -Xmx1024m"

# 配置容器启动后执行的命令
ENTRYPOINT ["/usr/local/primeton/startServer.sh"]