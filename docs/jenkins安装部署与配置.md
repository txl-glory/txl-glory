# jenkins 安装部署与配置

## 一： 基础环境准备

### 1.1 安装环境表
| 名称 | 版本 | 描述 |
| :---: | :----: | :---: |
| 操作系统 | Ubuntu 20.04 LTS | 操作系统 |
| jenkins | image: jenkins/jenkins:2.249.3-lts-centos7 | 持续集成工具 |
| docker.io | 20.10.7-0ubuntu1~20.04.1 | docker容器服务(- docker-ce 是 docker 官方维护的 - docker.io 是 Debian 团队维护的) |
| docker-compose | 1.25.0-1 | docker容器编排 |

### 1.2 安装docker和docker-compose环境
```shell
# 1.2.1 配置apt阿里云源(略)

# 1.2.2 安装docker.io
sudo apt-get install docker.io

# 1.2.3 安装docker-compose
sudo apt-get install docker-compose

# 1.2.4 配置docker加速
cat /etc/docker/daemon.json
{
        "registry-mirrors" : [
                "https://rnxly1wc.mirror.aliyuncs.com",
                "https://docker.mirrors.ustc.edu.cn",
                "http://hub-mirror.c.163.com",
                "http://registry.docker-cn.com"
        ]
}
```

## 二： 基于docker部署jenkins

```shell
# 2.1 手动创建docker和jenkins文件夹
sudo mkdir /usr/local/share/docker
sudo mkdir /usr/local/share/docker/jenkins

# 2.2 进入jenkins目录
cd /usr/local/share/docker/jenkins

# 2.3 创建docker-compose.yml文件，用于部署jenkins
yfhx@yfhx-jenkins:/usr/local/share/docker/jenkins$ sudo vim docker-compose.yml
version: "3.3"
services:
  jenkins:
    image: registry.cn-hangzhou.aliyuncs.com/txlhub/jenkins:1.0.0
    container_name: jenkins
    restart: always
    network_mode: "bridge"
    privileged: true
    environment:
      TZ: "Asia/Shanghai"
    ports:
      - "9003:8080"
      - "50000:50000"
        # volumes:
        # - ./data/var/jenkins_home:/var/jenkins_home

# 2.4 启动容器
yfhx@yfhx-jenkins:/usr/local/share/docker/jenkins$ sudo docker-compose up -d
Creating jenkins ... done

# 2.5 创建挂载文件夹，用于存储docker容器中的数据
yfhx@yfhx-jenkins:/usr/local/share/docker/jenkins$ sudo mkdir ./data
yfhx@yfhx-jenkins:/usr/local/share/docker/jenkins$ sudo mkdir ./data/var

# 2.6 查看docker容器信息
yfhx@yfhx-jenkins:/usr/local/share/docker/jenkins$ sudo docker ps -a
CONTAINER ID   IMAGE                                                    COMMAND                  CREATED       STATUS       PORTS                                                                                      NAMES
1450654da417   registry.cn-hangzhou.aliyuncs.com/txlhub/jenkins:1.0.0   "/sbin/tini -- /usr/…"   3 hours ago   Up 3 hours   0.0.0.0:50000->50000/tcp, :::50000->50000/tcp, 0.0.0.0:9003->8080/tcp, :::9003->8080/tcp   jenkins

# 2.7 复制容器中/var/jenkins_home目录到./data/var目录中
yfhx@yfhx-jenkins:/usr/local/share/docker/jenkins$ sudo docker cp 1450654da417:/var/jenkins_home/ ./data/var/

# 2.8 停止容器服务
yfhx@yfhx-jenkins:/usr/local/share/docker/jenkins$ sudo docker-compose down
Stopping jenkins ... done
Removing jenkins ... done

# 2.9 修改docker-compose.yml文件，把文件中挂载映射目录的注释放开
yfhx@yfhx-jenkins:/usr/local/share/docker/jenkins$ sudo vim docker-compose.yml
version: "3.3"
services:
  jenkins:
    image: registry.cn-hangzhou.aliyuncs.com/txlhub/jenkins:1.0.0
    container_name: jenkins
    restart: always
    network_mode: "bridge"
    privileged: true
    environment:
      TZ: "Asia/Shanghai"
    ports:
      - "9003:8080"
      - "50000:50000"
    volumes:
      - ./data/var/jenkins_home:/var/jenkins_home

# 2.10 再次启动docker容器服务
yfhx@yfhx-jenkins:/usr/local/share/docker/jenkins$ sudo docker-compose up -d
Creating jenkins ... done

# 2.11 查看docker容器启动日志
yfhx@yfhx-jenkins:/usr/local/share/docker/jenkins$ sudo docker-compose logs -f
Attaching to jenkins
jenkins    | Running from: /usr/share/jenkins/jenkins.war
jenkins    | webroot: EnvVars.masterEnvVars.get("JENKINS_HOME")
jenkins    | 2021-09-10 13:48:07.124+0000 [id=1]        INFO    org.eclipse.jetty.util.log.Log#initialized: Logging initialized @1902ms to org.eclipse.jetty.util.log.JavaUtilLog
jenkins    | 2021-09-10 13:48:07.290+0000 [id=1]        INFO    winstone.Logger#logInternal: Beginning extraction from war file
jenkins    | 2021-09-10 13:48:07.343+0000 [id=1]        WARNING o.e.j.s.handler.ContextHandler#setContextPath: Empty contextPath
jenkins    | 2021-09-10 13:48:07.445+0000 [id=1]        INFO    org.eclipse.jetty.server.Server#doStart: jetty-9.4.43.v20210629; built: 2021-06-30T11:07:22.254Z; git: 526006ecfa3af7f1a27ef3a288e2bef7ea9dd7e8; jvm 11.0.12+7
jenkins    | 2021-09-10 13:48:08.149+0000 [id=1]        INFO    o.e.j.w.StandardDescriptorProcessor#visitServlet: NO JSP Support for /, did not find org.eclipse.jetty.jsp.JettyJspServlet
jenkins    | 2021-09-10 13:48:08.236+0000 [id=1]        INFO    o.e.j.s.s.DefaultSessionIdManager#doStart: DefaultSessionIdManager workerName=node0
jenkins    | 2021-09-10 13:48:08.237+0000 [id=1]        INFO    o.e.j.s.s.DefaultSessionIdManager#doStart: No SessionScavenger set, using defaults
jenkins    | 2021-09-10 13:48:08.240+0000 [id=1]        INFO    o.e.j.server.session.HouseKeeper#startScavenging: node0 Scavenging every 600000ms
jenkins    | SLF4J: Class path contains multiple SLF4J bindings.
jenkins    | SLF4J: Found binding in [jar:file:/var/jenkins_home/war/WEB-INF/lib/slf4j-jdk14-1.7.32.jar!/org/slf4j/impl/StaticLoggerBinder.class]
jenkins    | SLF4J: Found binding in [jar:file:/usr/local/share/lib/maven-slf4j-provider-3.6.3.jar!/org/slf4j/impl/StaticLoggerBinder.class]
jenkins    | SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
jenkins    | SLF4J: Actual binding is of type [org.slf4j.impl.JDK14LoggerFactory]
jenkins    | 2021-09-10 13:48:09.229+0000 [id=1]        INFO    hudson.WebAppMain#contextInitialized: Jenkins home directory: /var/jenkins_home found at: EnvVars.masterEnvVars.get("JENKINS_HOME")
jenkins    | 2021-09-10 13:48:09.550+0000 [id=1]        INFO    o.e.j.s.handler.ContextHandler#doStart: Started w.@4287d447{Jenkins v2.311,/,file:///var/jenkins_home/war/,AVAILABLE}{/var/jenkins_home/war}
jenkins    | 2021-09-10 13:48:09.641+0000 [id=1]        INFO    o.e.j.server.AbstractConnector#doStart: Started ServerConnector@d35dea7{HTTP/1.1, (http/1.1)}{0.0.0.0:8080}
jenkins    | 2021-09-10 13:48:09.642+0000 [id=1]        INFO    org.eclipse.jetty.server.Server#doStart: Started @4423ms
jenkins    | 2021-09-10 13:48:09.649+0000 [id=23]       INFO    winstone.Logger#logInternal: Winstone Servlet Engine running: controlPort=disabled
jenkins    | 2021-09-10 13:48:10.163+0000 [id=30]       INFO    jenkins.InitReactorRunner$1#onAttained: Started initialization
jenkins    | 2021-09-10 13:48:10.349+0000 [id=28]       INFO    jenkins.InitReactorRunner$1#onAttained: Listed all plugins
jenkins    | WARNING: An illegal reflective access operation has occurred
jenkins    | WARNING: Illegal reflective access by com.google.inject.internal.cglib.core.$ReflectUtils$2 (file:/var/jenkins_home/war/WEB-INF/lib/guice-4.0.jar) to method java.lang.ClassLoader.defineClass(java.lang.String,byte[],int,int,java.security.ProtectionDomain)
jenkins    | WARNING: Please consider reporting this to the maintainers of com.google.inject.internal.cglib.core.$ReflectUtils$2
jenkins    | WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
jenkins    | WARNING: All illegal access operations will be denied in a future release
jenkins    | 2021-09-10 13:48:12.806+0000 [id=31]       INFO    jenkins.InitReactorRunner$1#onAttained: Prepared all plugins
jenkins    | 2021-09-10 13:48:12.815+0000 [id=29]       INFO    jenkins.InitReactorRunner$1#onAttained: Started all plugins
jenkins    | 2021-09-10 13:48:12.831+0000 [id=28]       INFO    jenkins.InitReactorRunner$1#onAttained: Augmented all extensions
jenkins    | 2021-09-10 13:48:13.350+0000 [id=30]       INFO    jenkins.InitReactorRunner$1#onAttained: System config loaded
jenkins    | 2021-09-10 13:48:13.351+0000 [id=28]       INFO    jenkins.InitReactorRunner$1#onAttained: System config adapted
jenkins    | 2021-09-10 13:48:13.352+0000 [id=28]       INFO    jenkins.InitReactorRunner$1#onAttained: Loaded all jobs
jenkins    | 2021-09-10 13:48:13.353+0000 [id=28]       INFO    jenkins.InitReactorRunner$1#onAttained: Configuration for all jobs updated
jenkins    | 2021-09-10 13:48:13.398+0000 [id=44]       INFO    hudson.model.AsyncPeriodicWork#lambda$doRun$0: Started Download metadata
jenkins    | 2021-09-10 13:48:13.457+0000 [id=44]       INFO    hudson.util.Retrier#start: Attempt #1 to do the action check updates server
jenkins    | 2021-09-10 13:48:13.711+0000 [id=28]       INFO    jenkins.install.SetupWizard#init:
jenkins    |
jenkins    | *************************************************************
jenkins    | *************************************************************
jenkins    | *************************************************************
jenkins    |
jenkins    | Jenkins initial setup is required. An admin user has been created and a password generated.
jenkins    | Please use the following password to proceed to installation:
jenkins    |
jenkins    | 1049159353a94df789ca131d9560f3bf
jenkins    |
jenkins    | This may also be found at: /var/jenkins_home/secrets/initialAdminPassword
jenkins    |
jenkins    | *************************************************************
jenkins    | *************************************************************
jenkins    | *************************************************************
jenkins    |

```

## 三： 配置jenkins

### 3.1 访问jenkins http://192.168.1.212:9003
