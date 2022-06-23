# Docker 部署 Confluence(破解版)

## 1 说明

### 1.1 素材
本文采用素材如下：
Docker镜像 Github链接(https://github.com/cptactionhank)
破解工具 Gitee链接(https://gitee.com/pengzhile/atlassian-agent) (https://zhile.io/2018/12/20/atlassian-license-crack.html)

采用以上工具，理论上可以破解几乎全部版本。

本地下载地址：https://files.cnblogs.com/files/sanduzxcvbnm/atlassian-agent-v1.2.3.zip

### 1.2 数据库
如果是选择外部数据库，大家可以按照这样创建：

```sql
# 创建confluence数据库及用户
CREATE DATABASE confdb CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
grant all on confdb.* to 'confuser'@'%' identified by '7FxxxzhO';

# confluence要求设置事务级别为READ-COMMITTED
set global tx_isolation='READ-COMMITTED';
```

## 2 安装 Confluence(7.4.0)
Atlassian Confluence（简称Confluence）是一个专业的wiki程序。它是一个知识管理的工具，通过它可以实现团队成员之间的协作和知识共享。

### 2.1 制作Docker破解容器

编写Dockerfile文件：
```dockerfile
FROM cptactionhank/atlassian-confluence:latest

USER root

# 将代理破解包加入容器
COPY "atlassian-agent.jar" /opt/atlassian/confluence/

# 设置启动加载代理包
RUN echo 'export CATALINA_OPTS="-javaagent:/opt/atlassian/confluence/atlassian-agent.jar ${CATALINA_OPTS}"' >> /opt/atlassian/confluence/bin/setenv.sh
```

### 2.2 下载破解文件

在gitee 中下载编译好的即可，放置在Dockerfile同目录下

JIRA
--Dockerfile
--atlassian-agent.jar

### 2.3 构建镜像

```sh
docker build -t confluence:latest .
```
结果如下：

```sh
Sending build context to Docker daemon  976.9kB
Step 1/4 : FROM cptactionhank/atlassian-confluence:latest
 ---> 080599d8b2d7
Step 2/4 : USER root
 ---> Running in 016cda821c07
Removing intermediate container 016cda821c07
 ---> 6506aa1b43c1
Step 3/4 : COPY "atlassian-agent.jar" /opt/atlassian/confluence/
 ---> 27ab3f8f23cc
Step 4/4 : RUN echo 'export CATALINA_OPTS="-javaagent:/opt/atlassian/confluence/atlassian-agent.jar ${CATALINA_OPTS}"' >> /opt/atlassian/confluence/bin/setenv.sh
 ---> Running in 68588c4f146c
Removing intermediate container 68588c4f146c
 ---> 45a74f5420da
Successfully built 45a74f5420da
Successfully tagged confluence:latest
```

### 2.4 启动容器
```sh
# 提前创建/home/confluence目录
docker run -d --name confluence \
  --restart always \
  -p 18010:8090 \
  -e TZ="Asia/Shanghai" \
  -v /home/confluence:/var/atlassian/confluence \
  confluence:latest
  ```

### 2.5 访问 confluence
访问 IP:18010，参照JIRA的安装流程，进行操作。可在引导过程中，与之前安装的JIRA进行绑定关联。
<div align="center">
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/设置confluence.png"  height="100%" width="100%">
</div>

