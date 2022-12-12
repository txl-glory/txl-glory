# docker 命令相关笔记

# ubuntu20.04 安装 docker 和 docker-compose

## 1：更改 apt 源

````bash
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse

## 2：安装docker.io和docker-compose
```bash
sudo apt-get update
sudo apt-get install docker.io docker-compose

# centos8安装docker-ce和docker-compose
## 0：背景介绍
现在centos已经到了8 ，一直在ubuntu环境使用docker.io&docker-compose，客户突然要求使用centos8，尝试安装docker-ce&docker-compose，不料竟然还报了个错（缺少依赖），故及时记录一下，方便其他同学。

## 1：安装步骤
```bash
# 1.1下载docker-ce的repo
curl https://download.docker.com/linux/centos/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo

# 1.2安装依赖（这是相比centos7的关键步骤）
yum install https://download.docker.com/linux/fedora/30/x86_64/stable/Packages/containerd.io-1.2.6-3.3.fc30.x86_64.rpm

# 1.3安装docker-ce
yum install docker-ce

# 1.4启动docker
systemctl start docker

# 1.5开机启动docker
systemctl enable docker

# 1.6安装docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 1.7添加操作权限
sudo chmod +x /usr/local/bin/docker-compose

# 1.8设置快捷
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# 1.9查看docker&docker-compose版本
docker --version
docker-compose --version
````

# docker 加速

```bash
xxx@xxx:/etc/docker$ cat daemon.json
{
        "registry-mirrors" : [
                "https://rnxly1wc.mirror.aliyuncs.com",
                "https://docker.mirrors.ustc.edu.cn",
                "http://hub-mirror.c.163.com",
                "http://registry.docker-cn.com"
        ]
}
```

## docker ps 显示指定的列

docker ps 默认的显示内容过多，当值过长时就会导致折行，可读性很差，所以希望只显示自己关心的某些列。

可以自己指定显示的模板，例如：

```shell script
sudo docker ps --format "table {{.ID}}\t{{.RunningFor}}\t{{.Names}}\t{{.Ports}}\t{{.Image}}"


# 可用的占位符
名称	含义
.ID	容器ID
.Image	镜像ID
.Command	执行的命令
.CreatedAt	容器创建时间
.RunningFor	运行时长
.Ports	暴露的端口
.Status	容器状态
.Names	容器名称
.Label	分配给容器的所有标签
.Mounts	容器挂载的卷
.Networks	容器所用的网络名称
```

# 删除所有 none 镜像

sudo docker rmi $(sudo docker images | grep "none" | awk '{print $3}')


# max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

```bash
1. 编辑文件/etc/sysctl.conf，在文件末尾加

vm.max_map_count=655360

2. 使配置立即生效
sysctl -p
```

## 因为sonarqube中集成了es，需要对服务器参数设置一下

```sh
sudo sysctl -w vm.max_map_count=524288
sudo sysctl -w fs.file-max=131072
ulimit -n 131072
ulimit -u 8192

echo "vm.max_map_count=524288" >> /etc/sysctl.conf
sysctl -p
```