## 0.Docker介绍

- Docker 是一个开源的应用容器引擎，基于 Go 语言 并遵从Apache2.0协议开源。
- Docker 可以让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。
- 容器是完全使用沙箱机制，相互之间不会有任何接口（类似 iPhone 的 app）,更重要的是容器性能开销极低。
- Docker 从 17.03 版本之后分为 CE（Community Edition: 社区版） 和 EE（Enterprise Edition: 企业版）。

## 1.Docker的应用场景

- Web 应用的自动化打包和发布。
- 自动化测试和持续集成、发布。
- 在服务型环境中部署和调整数据库或其他的后台应用。
- 从头编译或者扩展现有的 OpenShift 或 Cloud Foundry 平台来搭建自己的 PaaS 环境。

## 2.Docker的优点
- 简化程序：Docker让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的 Linux机器上，便可以实现虚拟化。Docker改变了虚拟化的方式，使开发者可以直接将自己的成果放入Docker中进行管理。方便快捷已经是 Docker的最大优势，过去需要用数天乃至数周的	任务，在Docker容器的处理下，只需要数秒就能完成。

- 避免选择恐惧症：如果你有选择恐惧症，还是资深患者。那么你可以使用 Docker 打包你的纠结！比如 Docker 镜像；Docker 镜像中包含了运行环境和配置，所以 Docker 可以简化部署多种应用实例工作。比如 Web 应用、后台应用、数据库应用、大数据应用比如 Hadoop 集群、消息队列等等都可以打包成一个镜像部署。

- 节省开支：一方面，云计算时代到来，使开发者不必为了追求效果而配置高额的硬件，Docker 改变了高性能必然高价格的思维定势。Docker 与云的结合，让云空间得到更充分的利用。不仅解决了硬件管理的问题，也改变了虚拟化的方式。

## 3.Docker安装

==前提条件:==
- Docker要求Ubuntu系统的内核版本高于3.10，通过 uname -r 命令查看你当前的内核版本。

```shell
## 使用脚本安装 docker
wget -qO- https://get.docker.com/ | sh

## ubuntu安装docker
sudo apt install docker.io

## 测试运行hello-world
docker run hello-world

## 镜像加速(鉴于国内网络问题，后续拉取 Docker 镜像十分缓慢，我们可以需要配置加速器来解决，我使用的是网易的镜像地址：http://hub-mirror.c.163.com。)
## 新版的 Docker 使用 /etc/docker/daemon.json（Linux） 或者 %programdata%\docker\config\daemon.json（Windows） 来配置 Daemon。请在该配置文件中加入（没有该文件的话，请先建一个）：

{
  "registry-mirrors": ["http://hub-mirror.c.163.com"]
}
```

## 4.Docker体验
- Docker 允许你在容器内运行应用程序， 使用 docker run 命令来在容器内运行一个应用程序。输出Hello world

```shell
## Docker 以 ubuntu15.10 镜像创建一个新容器，然后在容器里执行 bin/echo "Hello world"，然后输出结果。
docker run ubuntu:15.10 /bin/echo "Hello world"
```

- 各个参数解析：
  - docker: Docker 的二进制执行文件。
  - run:与前面的 docker 组合来运行一个容器。
  - ubuntu:15.10指定要运行的镜像，Docker首先从本地主机上查找镜像是否存在，如果不存在，Docker 就会从镜像仓库 Docker Hub 下载公共镜像。
  - /bin/echo "Hello world": 在启动的容器里执行的命令

## 5.Docker容器使用

- **docker客户端**
```shell
## docker客户端非常简单 ,我们可以直接输入 docker 命令来查看到 Docker 客户端的所有命令选项。

tianxuanling@txl-ubuntu1904-init:~$ docker

Usage:  docker [OPTIONS] COMMAND

A self-sufficient runtime for containers

Options:
      --config string      Location of client config files (default "/home/tianxuanling/.docker")
  -D, --debug              Enable debug mode
  -H, --host list          Daemon socket(s) to connect to
  -l, --log-level string   Set the logging level ("debug"|"info"|"warn"|"error"|"fatal") (default "info")
      --tls                Use TLS; implied by --tlsverify
      --tlscacert string   Trust certs signed only by this CA (default "/home/tianxuanling/.docker/ca.pem")
      --tlscert string     Path to TLS certificate file (default "/home/tianxuanling/.docker/cert.pem")
      --tlskey string      Path to TLS key file (default "/home/tianxuanling/.docker/key.pem")
      --tlsverify          Use TLS and verify the remote
  -v, --version            Print version information and quit

Management Commands:
  builder     Manage builds
  config      Manage Docker configs
  container   Manage containers
  engine      Manage the docker engine
  image       Manage images
  network     Manage networks
  node        Manage Swarm nodes
  plugin      Manage plugins
  secret      Manage Docker secrets
  service     Manage services
  stack       Manage Docker stacks
  swarm       Manage Swarm
  system      Manage Docker
  trust       Manage trust on Docker images
  volume      Manage volumes

Commands:
  attach      Attach local standard input, output, and error streams to a running container
  build       Build an image from a Dockerfile
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  deploy      Deploy a new stack or update an existing stack
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  exec        Run a command in a running container
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  images      List images
  import      Import the contents from a tarball to create a filesystem image
  info        Display system-wide information
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  login       Log in to a Docker registry
  logout      Log out from a Docker registry
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  ps          List containers
  pull        Pull an image or a repository from a registry
  push        Push an image or a repository to a registry
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  run         Run a command in a new container
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  search      Search the Docker Hub for images
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  version     Show the Docker version information
  wait        Block until one or more containers stop, then print their exit codes

Run 'docker COMMAND --help' for more information on a command.

## 可以通过命令 docker command --help 更深入的了解指定的 Docker 命令使用方法。
## 例如我们要查看 docker stats 指令的具体使用方法：
tianxuanling@txl-ubuntu1904-init:~$ docker stats --help

Usage:  docker stats [OPTIONS] [CONTAINER...]

Display a live stream of container(s) resource usage statistics

Options:
  -a, --all             Show all containers (default shows just running)
      --format string   Pretty-print images using a Go template
      --no-stream       Disable streaming stats and only pull the first result
      --no-trunc        Do not truncate output
```

- **运行一个web应用**

```shell
## 前面我们运行的容器并没有一些什么特别的用处。
## 接下来让我们尝试使用 docker 构建一个 web 应用程序。
## 我们将在docker容器中运行一个 Python Flask应用来运行一个web应用。

## 载入镜像
tianxuanling@txl-ubuntu1904-init:~$ sudo docker pull training/webapp
Using default tag: latest
latest: Pulling from training/webapp
e190868d63f8: Pull complete
909cd34c6fd7: Pull complete
0b9bfabab7c1: Pull complete
a3ed95caeb02: Pull complete
10bbbc0fc0ff: Pull complete
fca59b508e9f: Pull complete
e7ae2541b15b: Pull complete
9dd97ef58ce9: Pull complete
a4c1b0cb7af7: Pull complete
Digest: sha256:06e9c1983bd6d5db5fba376ccd63bfa529e8d02f23d5079b8f74a616308fb11d
Status: Downloaded newer image for training/webapp:latest

## 运行web应用
## 参数说明:
## -d:让容器在后台运行。
## -P:将容器内部使用的网络端口映射到我们使用的主机上。
tianxuanling@txl-ubuntu1904-init:~$ sudo docker run -d -P training/webapp python app.py
[sudo] password for tianxuanling:
c3fe0c87e5f494c9a55105e7bac9d65ab9fbda041e9a8ffa2a1d7231d512eec0
```

- **查看 WEB 应用容器**

```shell
## 使用 docker ps 来查看我们正在运行的容器：
tianxuanling@txl-ubuntu1904-init:~$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                     NAMES
c3fe0c87e5f4        training/webapp     "python app.py"     2 minutes ago       Up 2 minutes        0.0.0.0:32768->5000/tcp   flamboyant_diffie

## 这里多了端口信息。
PORTS
0.0.0.0:32768->5000/tcp

## Docker 开放了 5000 端口（默认 Python Flask 端口）映射到主机端口 32768 上。
## 这时我们可以通过浏览器访问WEB应用
http://192.168.153.8:32768

## 我们也可以通过 -p 参数来设置不一样的端口：
tianxuanling@txl-ubuntu1904-init:~$ sudo docker run -d -p 5000:5000 training/webapp python app.py
caf0cd11c184ba0cd0d124dc2a9124bd80ec7857db50973054407cf84e54bdcf

## docker ps查看正在运行的容器
tianxuanling@txl-ubuntu1904-init:~$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                     NAMES
caf0cd11c184        training/webapp     "python app.py"     6 seconds ago       Up 5 seconds        0.0.0.0:5000->5000/tcp    inspiring_proskuriakova
c3fe0c87e5f4        training/webapp     "python app.py"     8 minutes ago       Up 8 minutes        0.0.0.0:32768->5000/tcp   flamboyant_diffie

## 容器内部的 5000 端口映射到我们本地主机的 5000 端口上。这时候可以通过32768和5000两个端口访问web应用
http://192.168.153.8:32768
http://192.168.153.8:5000
```

- **查看 WEB 应用程序日志**

```shell
## docker logs [ID或者名字] 可以查看容器内部的标准输出。
tianxuanling@txl-ubuntu1904-init:~$ sudo docker logs -f caf0cd11c184
 * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
192.168.153.1 - - [27/Sep/2019 03:23:58] "GET / HTTP/1.1" 200 -
192.168.153.1 - - [27/Sep/2019 03:23:58] "GET /favicon.ico HTTP/1.1" 404 -
## -f: 让 docker logs 像使用 tail -f 一样来输出容器内部的标准输出。
## 从上面，我们可以看到应用程序使用的是5000端口并且能够查看到应用程序的访问日志。
```

- **查看WEB应用程序容器的进程**

```shell
## 我们还可以使用 docker top 来查看容器内部运行的进程
tianxuanling@txl-ubuntu1904-init:~$ sudo docker top caf0cd11c184
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
root                3996                3966                0                   03:23               ?                   00:00:00            python app.py
```

- **检查 WEB 应用程序**

```shell
## 使用 docker inspect 来查看 Docker 的底层信息。它会返回一个 JSON 文件记录着 Docker 容器的配置和状态信息。
tianxuanling@txl-ubuntu1904-init:~$ sudo docker inspect caf0cd11c184
[
    {
        "Id": "caf0cd11c184ba0cd0d124dc2a9124bd80ec7857db50973054407cf84e54bdcf",
        "Created": "2019-09-27T03:23:32.143879357Z",
        "Path": "python",
        "Args": [
            "app.py"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 3996,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2019-09-27T03:23:32.691435926Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:6fae60ef344644649a39240b94d73b8ba9c67f898ede85cf8e947a887b3e6557",
        "ResolvConfPath": "/var/lib/docker/containers/caf0cd11c184ba0cd0d124dc2a9124bd80ec7857db50973054407cf84e54bdcf/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/caf0cd11c184ba0cd0d124dc2a9124bd80ec7857db50973054407cf84e54bdcf/hostname",
        "HostsPath": "/var/lib/docker/containers/caf0cd11c184ba0cd0d124dc2a9124bd80ec7857db50973054407cf84e54bdcf/hosts",
        "LogPath": "/var/lib/docker/containers/caf0cd11c184ba0cd0d124dc2a9124bd80ec7857db50973054407cf84e54bdcf/caf0cd11c184ba0cd0d124dc2a9124bd80ec7857db50973054407cf84e54bdcf-json.log",
        "Name": "/inspiring_proskuriakova",
        "RestartCount": 0,
        "Driver": "overlay2",
        "Platform": "linux",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "docker-default",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "default",
            "PortBindings": {
                "5000/tcp": [
                    {
                        "HostIp": "",
                        "HostPort": "5000"
                    }
                ]
            },
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "CapAdd": null,
            "CapDrop": null,
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "shareable",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "runc",
            "ConsoleSize": [
                0,
                0
            ],
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": [],
            "BlkioDeviceReadBps": null,
            "BlkioDeviceWriteBps": null,
            "BlkioDeviceReadIOps": null,
            "BlkioDeviceWriteIOps": null,
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DeviceCgroupRules": null,
            "DiskQuota": 0,
            "KernelMemory": 0,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": null,
            "OomKillDisable": false,
            "PidsLimit": 0,
            "Ulimits": null,
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0,
            "MaskedPaths": [
                "/proc/asound",
                "/proc/acpi",
                "/proc/kcore",
                "/proc/keys",
                "/proc/latency_stats",
                "/proc/timer_list",
                "/proc/timer_stats",
                "/proc/sched_debug",
                "/proc/scsi",
                "/sys/firmware"
            ],
            "ReadonlyPaths": [
                "/proc/bus",
                "/proc/fs",
                "/proc/irq",
                "/proc/sys",
                "/proc/sysrq-trigger"
            ]
        },
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/cc6bdbfb8b9b5d5680f18712eaf19cff7e09064d6cc45ac44e711aef08885531-init/diff:/var/lib/docker/overlay2/d2e0dfc0a50a95e46afae2228c2c132f275c1e270dcb6286a53ee25c1724fe95/diff:/var/lib/docker/overlay2/8c7ce762d9e1fe1368a6ce9aec7ceb00f5579c30c3ce7d50533aa355736fac31/diff:/var/lib/docker/overlay2/b59a356993a1838f423683a5c39d3859c89e1351dd26f4c45be028aefc9ef4a4/diff:/var/lib/docker/overlay2/4e417eeb283b9ff94b3da08e9a10f5e6e796aeec7e95db4a3552ad1e919669eb/diff:/var/lib/docker/overlay2/e2ab2bdd16618fe279f5bc784b568147d39bed034d7be5f3a87c6a0a24fe4813/diff:/var/lib/docker/overlay2/ad8272c99c2f5c1ea78352420a80dbc14665f1733a9ab5f1c34fa44bdece9fd9/diff:/var/lib/docker/overlay2/8627cf8088dc93689c3c6b4ad1ea865b182dce2bd38be1be2ad8017591e440fe/diff:/var/lib/docker/overlay2/d622942f261bcc0b38ccc55b3dc644dd035cfcd8644f2450538fd51dbf52fc52/diff:/var/lib/docker/overlay2/519e4ef1cf17468a173579d74a0af97ff28f9c4a7ad24c0abc6ebe7401763665/diff:/var/lib/docker/overlay2/124f0b1239a3a294c9368b41aa019a8d3e945b465e100c267efcead442c29f25/diff:/var/lib/docker/overlay2/ca6aa1846628104f1ae944d79f06f6dd112d613c3cc88827463f98526b905c8c/diff:/var/lib/docker/overlay2/0714ae33cde9a365145e0b9efdaca5e9174dc6813175e0cd6e98d13b2eadf3c1/diff:/var/lib/docker/overlay2/83f2745917fc85565bbe76bb8e04272444fd5e193f2de35d0addd299152c2f26/diff",
                "MergedDir": "/var/lib/docker/overlay2/cc6bdbfb8b9b5d5680f18712eaf19cff7e09064d6cc45ac44e711aef08885531/merged",
                "UpperDir": "/var/lib/docker/overlay2/cc6bdbfb8b9b5d5680f18712eaf19cff7e09064d6cc45ac44e711aef08885531/diff",
                "WorkDir": "/var/lib/docker/overlay2/cc6bdbfb8b9b5d5680f18712eaf19cff7e09064d6cc45ac44e711aef08885531/work"
            },
            "Name": "overlay2"
        },
        "Mounts": [],
        "Config": {
            "Hostname": "caf0cd11c184",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "5000/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "python",
                "app.py"
            ],
            "Image": "training/webapp",
            "Volumes": null,
            "WorkingDir": "/opt/webapp",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {}
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "6db72877646e72e76a04e0f822c562151ca07d31ad321c62dfb437fca7998fbe",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": {
                "5000/tcp": [
                    {
                        "HostIp": "0.0.0.0",
                        "HostPort": "5000"
                    }
                ]
            },
            "SandboxKey": "/var/run/docker/netns/6db72877646e",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "e425e5fcb8bbfba4dc5e39e32fb54bcdb17d88fe3524c555edb9981ac825cf68",
            "Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.3",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:03",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "bd2f061210ffdbaf71b2bba4a8e8978cc47588851f2b7ad7ae7d393ccf86af26",
                    "EndpointID": "e425e5fcb8bbfba4dc5e39e32fb54bcdb17d88fe3524c555edb9981ac825cf68",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.3",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:03",
                    "DriverOpts": null
                }
            }
        }
    }
]

```

- **停止 WEB 应用容器**

```shell
tianxuanling@txl-ubuntu1904-init:~$ sudo docker stop caf0cd11c184
caf0cd11c184
```

- **重启WEB应用容器**

```shell
## 已经停止的容器，我们可以使用命令 docker start 来启动。
tianxuanling@txl-ubuntu1904-init:~$ sudo docker start caf0cd11c184
caf0cd11c184

## docker ps -l 查询最后一次创建的容器：
tianxuanling@txl-ubuntu1904-init:~$ sudo docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                    NAMES
caf0cd11c184        training/webapp     "python app.py"     13 minutes ago      Up 42 seconds       0.0.0.0:5000->5000/tcp   inspiring_proskuriakova
```

- **移除WEB应用容器**

```shell
## 我们可以使用 docker rm 命令来删除不需要的容器
tianxuanling@txl-ubuntu1904-init:~$ sudo docker stop caf0cd11c184
caf0cd11c184

## 删除容器时，容器必须是停止状态，否则会报如下错误
tianxuanling@txl-ubuntu1904-init:~$ sudo docker rm caf0cd11c184
Error response from daemon: You cannot remove a running container caf0cd11c184ba0cd0d124dc2a9124bd80ec7857db50973054407cf84e54bdcf. Stop the container before attempting removal or force remove
```

## 6.Docker镜像使用
==当运行容器时，使用的镜像如果在本地中不存在，docker 就会自动从 docker 镜像仓库中下载，默认是从 Docker Hub 公共镜像源下载。==

- **列出镜像列表**

```shell
tianxuanling@txl-ubuntu1904-init:~$ sudo docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              latest              2ca708c1c9cc        8 days ago          64.2MB
httpd               latest              19459a872194        2 weeks ago         154MB
training/webapp     latest              6fae60ef3446        4 years ago         349MB

## 各个选项说明:
## REPOSITORY：表示镜像的仓库源
## TAG：镜像的标签
## IMAGE ID：镜像ID
## CREATED：镜像创建时间
## SIZE：镜像大小
```

- **获取一个新的镜像**

```shell
## 当我们在本地主机上使用一个不存在的镜像时 Docker 就会自动下载这个镜像。如果我们想预先下载这个镜像，我们可以使用 docker pull 命令来下载它。
tianxuanling@txl-ubuntu1904-init:~$ sudo docker pull ubuntu
Using default tag: latest
latest: Pulling from library/ubuntu
5667fdb72017: Pull complete
d83811f270d5: Pull complete
ee671aafb583: Pull complete
7fc152dfb3a6: Pull complete
Digest: sha256:b88f8848e9a1a4e4558ba7cfc4acc5879e1d0e7ac06401409062ad2627e6fb58
Status: Downloaded newer image for ubuntu:latest
```

- **查找镜像**

```shell
## 我们可以从 Docker Hub 网站来搜索镜像，Docker Hub 网址为： https://hub.docker.com/
## 我们也可以使用 docker search 命令来搜索镜像。比如我们需要一个httpd的镜像来作为我们的web服务。我们可以通过 docker search 命令搜索 httpd 来寻找适合我们的镜像。
tianxuanling@txl-ubuntu1904-init:~$ sudo docker search httpd
NAME                                 DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
httpd                                The Apache HTTP Server Project                  2662                [OK]
centos/httpd                                                                         25                                      [OK]
centos/httpd-24-centos7              Platform for running Apache httpd 2.4 or bui…   24
arm32v7/httpd                        The Apache HTTP Server Project                  9
armhf/httpd                          The Apache HTTP Server Project                  8
salim1983hoop/httpd24                Dockerfile running apache config                2                                       [OK]
lead4good/httpd-fpm                  httpd server which connects via fcgi proxy h…   1                                       [OK]
rgielen/httpd-image-simple           Docker image for simple Apache httpd based o…   1                                       [OK]
itsziget/httpd24                     Extended HTTPD Docker image based on the off…   0                                       [OK]
dockerpinata/httpd                                                                   0
manasip/httpd                                                                        0
interlutions/httpd                   httpd docker image with debian-based config …   0                                       [OK]
solsson/httpd-openidc                mod_auth_openidc on official httpd image, ve…   0                                       [OK]
appertly/httpd                       Customized Apache HTTPD that uses a PHP-FPM …   0                                       [OK]
amd64/httpd                          The Apache HTTP Server Project                  0
izdock/httpd                         Production ready Apache HTTPD Web Server + m…   0
manageiq/httpd_configmap_generator   Httpd Configmap Generator                       0                                       [OK]
buzzardev/httpd                      Based on the official httpd image               0                                       [OK]
publici/httpd                        httpd:latest                                    0                                       [OK]
ppc64le/httpd                        The Apache HTTP Server Project                  0
tugboatqa/httpd                      The Apache HTTP Server Project                  0
alvistack/httpd                      Docker Image Packaging for Apache               0                                       [OK]
waja/httpdiff                        Docker image for httpdiff: https://github.co…   0                                       [OK]
manageiq/httpd                       Container with httpd, built on CentOS for Ma…   0                                       [OK]
trollin/httpd                                                                        0

## NAME:镜像仓库源的名称
## DESCRIPTION:镜像的描述
## OFFICIAL:是否docker官方发布
```

- **构建镜像**
```shell
## 我们使用命令 docker build ， 从零开始来创建一个新的镜像。为此，我们需要创建一个 Dockerfile 文件，其中包含一组指令来告诉 Docker 如何构建我们的镜像。
tianxuanling@txl-ubuntu1904-init:~$ cat Dockerfile
FROM    centos:6.7
MAINTAINER      tianxuanling "623911519@qq.com"
RUN     /bin/echo 'root:123456' |chpasswd
RUN     useradd tianxuanling
RUN     /bin/echo 'tianxuanling:123456' |chpasswd
RUN     /bin/echo -e "LANG=\"en_US.UTF-8\"" >/etc/default/local
EXPOSE  22
EXPOSE  80
CMD     /usr/sbin/sshd -D

## 每一个指令都会在镜像上创建一个新的层，每一个指令的前缀都必须是大写的。
## 第一条FROM，指定使用哪个镜像源
## RUN 指令告诉docker 在镜像内执行命令，安装了什么。。。
## 然后，我们使用 Dockerfile 文件，通过 docker build 命令来构建一个镜像。

## 参数说明：
## -t ：指定要创建的目标镜像名
## . ：Dockerfile 文件所在目录，可以指定Dockerfile 的绝对路径
tianxuanling@txl-ubuntu1904-init:~$ sudo docker build -t tianxuanling/centos:6.7 .
Sending build context to Docker daemon  20.99kB
Step 1/9 : FROM    centos:6.7
6.7: Pulling from library/centos
cbddbc0189a0: Pull complete
Digest: sha256:4c952fc7d30ed134109c769387313ab864711d1bd8b4660017f9d27243622df1
Status: Downloaded newer image for centos:6.7
 ---> 9f1de3c6ad53
Step 2/9 : MAINTAINER      tianxuanling "623911519@qq.com"
 ---> Running in ac457e907dab
Removing intermediate container ac457e907dab
 ---> a09c89199f9e
Step 3/9 : RUN     /bin/echo 'root:123456' |chpasswd
 ---> Running in c8cd475b31d6
Removing intermediate container c8cd475b31d6
 ---> 0e0c646eb8cc
Step 4/9 : RUN     useradd tianxuanling
 ---> Running in d15b96216a5d
Removing intermediate container d15b96216a5d
 ---> c8a133f0354d
Step 5/9 : RUN     /bin/echo 'tianxuanling:123456' |chpasswd
 ---> Running in abd80d4318df
Removing intermediate container abd80d4318df
 ---> d7da0e33f8ea
Step 6/9 : RUN     /bin/echo -e "LANG=\"en_US.UTF-8\"" >/etc/default/local
 ---> Running in a2ea3fa9bbc3
Removing intermediate container a2ea3fa9bbc3
 ---> 1c5f22f52af2
Step 7/9 : EXPOSE  22
 ---> Running in 8f37f305552a
Removing intermediate container 8f37f305552a
 ---> 591658a74ecb
Step 8/9 : EXPOSE  80
 ---> Running in 04a73cdc7007
Removing intermediate container 04a73cdc7007
 ---> 1615c1fa71eb
Step 9/9 : CMD     /usr/sbin/sshd -D
 ---> Running in a723394e6e89
Removing intermediate container a723394e6e89
 ---> 1db758275bcb
Successfully built 1db758275bcb
Successfully tagged tianxuanling/centos:6.7

## 查看镜像
tianxuanling@txl-ubuntu1904-init:~$ sudo docker images
REPOSITORY            TAG                 IMAGE ID            CREATED              SIZE
tianxuanling/centos   6.7                 1db758275bcb        About a minute ago   191MB
ubuntu                latest              2ca708c1c9cc        8 days ago           64.2MB
httpd                 latest              19459a872194        2 weeks ago          154MB
centos                6.7                 9f1de3c6ad53        6 months ago         191MB
training/webapp       latest              6fae60ef3446        4 years ago          349MB
```

- **设置镜像标签**

```shell
## 我们可以使用 docker tag 命令，为镜像添加一个新的标签。
tianxuanling@txl-ubuntu1904-init:~$ sudo docker tag 1db758275bcb tianxuanling/centos:devdocker tag 1db758275bcb tianxuanling/centos:dev

## docker tag 镜像ID，这里是 1db758275bcb ,用户名称、镜像源名(repository name)和新的标签名(tag)。
## 使用 docker images 命令可以看到，ID为1db758275bcb的镜像多一个标签。
tianxuanling@txl-ubuntu1904-init:~$ sudo docker images
REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
tianxuanling/centos   6.7                 1db758275bcb        5 minutes ago       191MB
tianxuanling/centos   dev                 1db758275bcb        5 minutes ago       191MB
ubuntu                latest              2ca708c1c9cc        8 days ago          64.2MB
httpd                 latest              19459a872194        2 weeks ago         154MB
centos                6.7                 9f1de3c6ad53        6 months ago        191MB
training/webapp       latest              6fae60ef3446        4 years ago         349MB

```
