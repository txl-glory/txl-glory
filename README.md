# 一: ubuntu20.04 安装 docker.io 和 docker-compose

## 1.1 更改 apt 源

```shell script
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
```

## 1.2 安装 docker.io 和 docker-compose

```shell script
sudo apt-get update
sudo apt-get install docker.io docker-compose
```

# 二: centos8 安装 docker-ce 和 docker-compose

## 2.1 背景介绍

现在 centos 已经到了 8 ，一直在 ubuntu 环境使用 docker.io&docker-compose，客户突然要求使用 centos8，尝试安装 docker-ce&docker-compose，不料竟然还报了个错（缺少依赖），故及时记录一下，方便其他同学。

## 2.2 安装步骤

```shell script
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
```

# 三: docker 加速

```shell script
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

# 四：docker 查看资源情况

```shell
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
```

npm install --registry=https://registry.npm.taobao.org
