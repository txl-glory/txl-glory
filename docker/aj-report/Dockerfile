# 基础镜像
FROM  openjdk:8-jdk

# author
MAINTAINER zhaosh

# 拷贝文件到容器
ADD ./aj-report-0.9.9 /usr/local/share/aj-report-0.9.9

# 执行命令
RUN chmod +x /usr/local/share/aj-report-0.9.9/bin/start.sh

# 进入目录
WORKDIR /usr/local/share/aj-report-0.9.9

#容器对外开放端口
EXPOSE 9095

# 配置容器启动后执行的命令
ENTRYPOINT ["/usr/local/share/aj-report-0.9.9/bin/start.sh"]