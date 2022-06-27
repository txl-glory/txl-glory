# 基础镜像
FROM atlassian/confluence:7.12.6

# 维护者
LABEL shuyuan.timespace.image.authors="zhaosh"

# 设置用户和组
USER root:root

# 拷贝文件到容器
COPY ./atlassian-agent-v1.3.1/atlassian-agent.jar /opt/atlassian/confluence/

# 设置启动加载代理包
RUN echo 'export CATALINA_OPTS="-javaagent:/opt/atlassian/confluence/atlassian-agent.jar ${CATALINA_OPTS}"' >> /opt/atlassian/confluence/bin/setenv.sh