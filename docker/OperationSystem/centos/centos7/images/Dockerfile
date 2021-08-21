FROM centos:7

MAINTAINER TXL

#安装jdk环境
RUN yum install openssh-server.x86_64 java-1.8.0-openjdk.x86_64 -y

#定义环境变量
ENV WORK_HOME /usr/local

#设置进入容器后的主目录
WORKDIR $WORK_HOME

#拷贝并解压tomcat
ADD apache-tomcat-8.5.66.tar.gz $WORK_HOME
RUN tar -xvf apache-tomcat-8.5.66.tar.gz

#设置tomcat环境变量
ENV TOMCAT_HOME $WORK_HOME/apache-tomcat-8.5.66

#默认端口开放
EXPOSE 22 8080

#运行命令
CMD ["/usr/local/apache-tomcat-8.5.66/bin/startup.sh"]