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
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/shezhi-confluence.png"  height="100%" width="100%">
</div>
我们就选择一个应用吧
<div align="center">
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/huoquyingyong.png"  height="100%" width="100%">
</div>

### 2.6 破解
生成confluence许可命令参照如下：
```sh
# 设置产品类型：-p conf， 详情可执行：java -jar atlassian-agent.jar 
java -jar atlassian-agent.jar -d -m test@test.com -n BAT -p conf -o http://192.168.0.221 -s BTW4-2T4Y-9BTK-R0DP
```

复制服务器ID: BTW4-2T4Y-9BTK-R0DP
在本地存放atlassian-agent.jar的目录下执行命令，生成许可证：
需替换邮箱（test@test.com）、名称（BAT）、访问地址（http://192.168.0.89）、服务器ID（BTW4-2T4Y-9BTK-R0DP）为你的信息

```sh
java -jar atlassian-agent.jar \
  -d -m test@test.com -n BAT \
  -p jira -o http://192.168.0.89 \
  -s BTW4-2T4Y-9BTK-R0DP
```

例如我的信息如下，生成许可证：

```sh
java -jar atlassian-agent.jar \
  -d -m wangzan18@126.com -n BAT \
  -p conf -o http://confluence.wzlinux.com \
  -s BTW4-2T4Y-9BTK-R0DP

====================================================
=======        Atlassian Crack Agent         =======
=======           https://zhile.io           =======
=======          QQ Group: 30347511          =======
====================================================

Your license code(Don't copy this line!!!): 

AAABXQ0ODAoPeJx1kV9vgjAUxd/7KUj2XG1R5p+EZArEmYEsotteK7tqEyikLW7s069UzJJlS/rQn
HtPf/fc3mWNcBLWOpQ41JuT6dylTpDtHJe4BCWMCw2CiRyiz5rLNmQafJdMZ5hMzEExz0Gof4ohq
FzyWvNK+HtR8JJreHeKq8U5tM5Z61rNh8OvMy9gwCsUVEKzXG9YCf5ysUMZyAvIdegvR49jHNL0F
a+25A0/Be4K5ZU4DjZNeQCZHvcKpPIxRak8McEVs9QOYN7vOosGTIpBXpXS1MRJddcbMDJBC/+Di
dMXE3T6QN17W7aIPuOurcEOFqRJEm2D9SJGgQQL6pO7BBMPU3Jbixk8XodZtMEx9aYzMht7hI4mH
jKS/4dscWYcfgFfywZQdGFFc41yZIUC9NzI/MwU/AZmzeFn19Zq38o0kxpkb7aScbIARKfavv47X
sz6Oq/7DWevrTUwLgIVAIEyoNFjmUFyTJOVUzmxTJTM14S8AhUAkaRbRjdl4D9MZtO6l5nCHcR2B
80=X02h9
```

将生成的许可证复制到页面，完成破解。
<div align="center">
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/shouquanma.png"  height="100%" width="100%">
</div>

选择单机模式，并设置数据库
<div align="center">
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/bushuleixing.png"  height="100%" width="100%">
</div>

需要事先创建数据库，并且设置如下：
<div align="center">
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/shujukushezhi.png"  height="100%" width="100%">
</div>

还有开头的事务级别
```sql
mysql> set global tx_isolation='READ-COMMITTED';
Query OK, 0 rows affected (0.00 sec)
```

注意一下：数据库url连接中用的是utf8,不能用utf8mb4.

```
jdbc:mysql://192.168.0.254/confluence?useUnicode=true&characterEncoding=utf8
```
<div align="center">
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/shezhishujuku.png"  height="100%" width="100%">
</div>

### 2.7 配置 confluence
我们做个示范站点
<div align="center">
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/jiazaineirong.png"  height="100%" width="100%">
</div>

配置用户管理，这里我们选择之前创建好的 jira
<div align="center">
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/peizhiyonghu.png"  height="100%" width="100%">
</div>

配置连接信息
<div align="center">
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/jiralianjie.png"  height="100%" width="100%">
</div>

同步数据
<div align="center">
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/tongbushuju.png"  height="100%" width="100%">
</div>

<div align="center">
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/shezhichenggong.png"  height="100%" width="100%">
</div>
登陆查看授权情况
站点管理，一般设置，授权细节
<div align="center">
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/shouquanxijie.png"  height="100%" width="100%">
</div>
<div align="center">
<img src="https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/confluence/zhandianguanli.png"  height="100%" width="100%">
</div>

## 3 乱码问题
在我们正常安装之后，中文可能会有乱码，我们修改一下连接字符串，在 confluence 的家目录下面，有一个配置文件confluence.cfg.xml，找到hibernate.connection.url，在数据库字符串后面加上如下字符，整体结果如下：
```
jdbc:mysql://172.17.64.10/confdb?useUnicode=true&characterEncoding=utf8
jdbc:mysql://192.168.1.211:3306/confluence?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT%2B8
jdbc:mysql://192.168.1.211:3306/confluence?useUnicode=true&characterEncoding=utf8&useSSL=false
```
记住，里面的amp;不要省略。
如果可以的话，把数据库的字符串改成utf8mb4