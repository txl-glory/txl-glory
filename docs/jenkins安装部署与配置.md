# jenkins 安装部署与配置

## 1 基础环境准备

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

## 2 基于docker部署jenkins

```shell
# 2.1 手动创建docker和jenkins文件夹
sudo mkdir /usr/local/share/docker
sudo mkdir /usr/local/share/docker/jenkins

# 2.2 进入jenkins目录
cd /usr/local/share/docker/jenkins

# 2.3 创建docker-compose.yml文件，用于部署jenkins

```