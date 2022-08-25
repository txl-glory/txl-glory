Centos7 系统上，如果默认直接使用 yum install docker 安装 docker，一般版本比较低，有些情况下不适用（传送门），

下面介绍利用 yum 安装指定版本的 docker：

1、docker 要求 Centos 系统的内核版本高于 3.10，查看内核版本：

# uname -a

2、删除旧版本的 docker（若没装过则省略）

# yum remove docker docker-common docker-selinux docker-engine

3、安装需要的软件包

# yum install -y yum-utils device-mapper-persistent-data lvm2

4、设置 Docker yum 源

# yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

5、查看仓库中所有的 docker 版本

# yum list docker-ce --showduplicates | sort -r

6、安装指定版本 docker

# yum install -y --setopt=obsoletes=0 docker-ce-18.06.1.ce-3.el7

7、设置自启动

# 开机自启动

# systemctl enable docker

# 启动 docker

# systemctl start docker

# 查看状态

# systemctl status docker
