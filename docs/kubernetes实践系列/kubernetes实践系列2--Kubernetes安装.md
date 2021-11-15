# <center>Kubernetes 安装</center>

搭建Kubernetes集群环境有以下三种方式：

一：minikube

Minikube是一个工具，可以在本地快速运行一个单点的Kubernetes，尝试Kubernetes或日常开发的用户使用。不能用于生产环境。

二：kubeadm

Kubeadm也是一个工具，提供kubeadm init和kubeadm join，用于快速部署Kubernetes集群。

三：二进制包

从官方下载发行版的二进制包，手动部署每个组件，组成Kubernetes集群。

我们选择kubeadm安装方式来快速部署kubernetes集群。

---

0.环境说明

主机名 | IP地址 | 说明
---|---|---
txl-ubuntu-18-10-master0 | 192.168.100.10 | master节点
txl-ubuntu-18-10-node0 | 192.168.100.20 | node节点

==注：本次旨在演示kubernetes安装过程，因此选择1master和1node来进行实操，高可用集群会在后续文章中探讨==

---
1.基础配置(所有k8s节点)

```shell
#1.1 同步时区及时间
sudo tzselect
sudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
sudo ntpdate time.windows.com
tianxuanling@txl-ubuntu-18-10-master0:~$ date -R
Thu, 14 Feb 2019 16:35:04 +0800

#1.2 系统版本
tianxuanling@txl-ubuntu-18-10-master0:~$ cat /etc/lsb-release 
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.10
DISTRIB_CODENAME=cosmic
DISTRIB_DESCRIPTION="Ubuntu 18.10"

#1.3 host文件配置
tianxuanling@txl-ubuntu-18-10-master0:~$ cat /etc/hosts
127.0.0.1	localhost.localdomain	localhost
::1		localhost6.localdomain6	localhost6
192.168.100.10	txl-ubuntu-18-10-master0
192.168.100.20	txl-ubuntu-18-10-node0

#1.4 apt源配置
tianxuanling@txl-ubuntu-18-10-master0:~$ cat /etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu cosmic main restricted
deb http://archive.ubuntu.com/ubuntu cosmic-updates main restricted
deb http://archive.ubuntu.com/ubuntu cosmic universe
deb http://archive.ubuntu.com/ubuntu cosmic-updates universe
# 系统安装源
deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted
deb http://mirrors.aliyun.com/ubuntu/ xenial universe
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe
deb http://mirrors.aliyun.com/ubuntu/ xenial multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
# kubeadm及kubernetes组件安装源
deb https://mirrors.aliyun.com/kubernetes/apt kubernetes-xenial main

#1.5 更新apt源
sudo apt-get update
# 如果有报错的话，执行下面命令
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6A030B21BA07F4FB
```
---

2.关闭交换空间(所有k8s节点)

```shell
#2.1 关闭交换空间
sudo swapoff -a
/etc/fstab里面注释掉swap部分
```
---

3.ssh免密(所有k8s节点)

```shell
#3.1 生成私钥和公钥,一路回车即可
tianxuanling@txl-ubuntu-18-10-master0:~$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/tianxuanling/.ssh/id_rsa): 
Created directory '/home/tianxuanling/.ssh'.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/tianxuanling/.ssh/id_rsa.
Your public key has been saved in /home/tianxuanling/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:V2qVhFgJ5LYbyLEVfUxLYCa++DjywCy0aL8LBuVYzGo tianxuanling@txl-ubuntu-18-10-master0
The key's randomart image is:
+---[RSA 2048]----+
|       .===*+    |
| o     o.=+ooo   |
|  =   . =  .=    |
| *   . B o +     |
|+Eo   = S +      |
|oo +   o =       |
|.+o = o o        |
|o o. + .         |
|   +o .          |
+----[SHA256]-----+

#3.2 分发公钥到各k8s节点
ssh-copy-id tianxuanling@txl-ubuntu-18-10-master0
ssh-copy-id tianxuanling@txl-ubuntu-18-10-node0

#3.3 验证ssh免密是否成功，如果能直接进入node0节点，就说明ssh免密成功
tianxuanling@txl-ubuntu-18-10-master0:~/.ssh$ ssh txl-ubuntu-18-10-node0
Welcome to Ubuntu 18.10 (GNU/Linux 4.18.0-15-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu Feb 14 17:23:01 CST 2019

  System load:  0.0                 Processes:             89
  Usage of /:   0.6% of 1006.92GB   Users logged in:       1
  Memory usage: 5%                  IP address for enp0s3: 192.168.100.20
  Swap usage:   0%

 * 'snap info' now shows the freshness of each channel.
   Try 'snap info microk8s' for all the latest goodness.


54 packages can be updated.
0 updates are security updates.


*** System restart required ***
Last login: Thu Feb 14 15:38:35 2019 from 192.168.100.1
tianxuanling@txl-ubuntu-18-10-node0
```
---

4.安装docker(所有k8s节点)

```shell
#4.1 更新apt源
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6A030B21BA07F4FB
sudo apt-get update

#4.2 查看docker版本
tianxuanling@txl-ubuntu-18-10-master0:~$ sudo apt show docker.io
Package: docker.io
Version: 18.06.1-0ubuntu1.2

#4.3 安装daocker
sudo apt-get install docker.io

#4.4 查看docker版本
tianxuanling@txl-ubuntu-18-10-master0:~$ sudo docker version
Client:
 Version:           18.06.1-ce
 API version:       1.38
 Go version:        go1.10.4
 Git commit:        e68fc7a
 Built:             Fri Jan 25 14:34:22 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          18.06.1-ce
  API version:      1.38 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       e68fc7a
  Built:            Thu Jan 24 10:47:43 2019
  OS/Arch:          linux/amd64
  Experimental:     false
  
 #4.5 查验docker
 tianxuanling@txl-ubuntu-18-10-master0:~$ sudo systemctl status docker.service
● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; disabled; vendor preset: enabled)
   Active: active (running) since Thu 2019-02-14 17:40:47 CST; 8min ago
     Docs: https://docs.docker.com
 Main PID: 5303 (dockerd)
    Tasks: 18
   Memory: 45.5M
   CGroup: /system.slice/docker.service
           ├─5303 /usr/bin/dockerd -H fd://
           └─5326 docker-containerd --config /var/run/docker/containerd/containerd.toml
           
#4.6 配置docker，在/etc/docker目录下创建daemon.json文件并添加如下内容
tianxuanling@txl-ubuntu-18-10-master0:/etc/docker$ cat daemon.json 
{
	"bip": "10.244.0.1/24",
	"registry-mirrors": ["https://registry.docker-cn.com"]
}           

#4.7 重启docker服务
sudo systemctl restart docker.service
```
---

5.拉取镜像(由于网络被墙，所以需要提前拉取kubernetes相关的image)
目前最新的稳定发行版是1.13.3，我们本次就来安装这个版本


```shell
#5.1 执行下列命令拉取相关的docker镜像
sudo docker pull mirrorgooglecontainers/kube-apiserver-amd64:v1.13.3
sudo docker pull mirrorgooglecontainers/kube-controller-manager-amd64:v1.13.3
sudo docker pull mirrorgooglecontainers/kube-scheduler-amd64:v1.13.3
sudo docker pull mirrorgooglecontainers/kube-proxy-amd64:v1.13.3
sudo docker pull mirrorgooglecontainers/pause:3.1
sudo docker pull mirrorgooglecontainers/etcd-amd64:3.2.24
sudo docker pull coredns/coredns:1.2.6
sudo docker pull siriuszg/kubernetes-dashboard-amd64:v1.10.0
sudo docker pull mirrorgooglecontainers/heapster-grafana-amd64:v5.0.4
sudo docker pull mirrorgooglecontainers/heapster-amd64:v1.5.4
sudo docker pull mirrorgooglecontainers/heapster-influxdb-amd64:v1.5.2
sudo docker pull sapcc/tiller:v2.11.0
sudo docker pull googlecontainer/addon-resizer:1.7

#5.2 打标签
sudo docker tag docker.io/mirrorgooglecontainers/kube-apiserver-amd64:v1.13.3 k8s.gcr.io/kube-apiserver:v1.13.3
sudo docker tag docker.io/mirrorgooglecontainers/kube-controller-manager-amd64:v1.13.3 k8s.gcr.io/kube-controller-manager:v1.13.3
sudo docker tag docker.io/mirrorgooglecontainers/kube-scheduler-amd64:v1.13.3 k8s.gcr.io/kube-scheduler:v1.13.3
sudo docker tag docker.io/mirrorgooglecontainers/kube-proxy-amd64:v1.13.3 k8s.gcr.io/kube-proxy:v1.13.3
sudo docker tag docker.io/mirrorgooglecontainers/pause:3.1  k8s.gcr.io/pause:3.1
sudo docker tag docker.io/mirrorgooglecontainers/etcd-amd64:3.2.24  k8s.gcr.io/etcd:3.2.24
sudo docker tag docker.io/coredns/coredns:1.2.6  k8s.gcr.io/coredns:1.2.6
sudo docker tag siriuszg/kubernetes-dashboard-amd64:v1.10.0  k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.0
sudo docker tag mirrorgooglecontainers/heapster-grafana-amd64:v5.0.4 k8s.gcr.io/heapster-grafana-amd64:v5.0.4
sudo docker tag mirrorgooglecontainers/heapster-amd64:v1.5.4 k8s.gcr.io/heapster-amd64:v1.5.4
sudo docker tag mirrorgooglecontainers/heapster-influxdb-amd64:v1.5.2 k8s.gcr.io/heapster-influxdb-amd64:v1.5.2
sudo docker tag sapcc/tiller:v2.11.0 gcr.io/kubernetes-helm/tiller:v2.11.0
sudo docker tag googlecontainer/addon-resizer:1.7 k8s.gcr.io/addon-resizer:1.7

#5.3 查看kubeadm
tianxuanling@txl-ubuntu-18-10-master0:~$ sudo apt show kubeadm
Package: kubeadm
Version: 1.13.3-00
Priority: optional
Section: misc
Maintainer: Kubernetes Authors <kubernetes-dev+release@googlegroups.com>
Installed-Size: 36.4 MB
Depends: kubelet (>= 1.6.0), kubectl (>= 1.6.0), kubernetes-cni (= 0.6.0), cri-tools (>= 1.12.0)
Homepage: https://kubernetes.io
Download-Size: 7,364 kB
APT-Sources: https://mirrors.aliyun.com/kubernetes/apt kubernetes-xenial/main amd64 Packages
Description: Kubernetes Cluster Bootstrapping Tool
 The Kubernetes command line tool for bootstrapping a Kubernetes cluster.

N: There are 89 additional records. Please use the '-a' switch to see them.

#5.4 安装kubeadm（所有k8s节点）
sudo apt-get install kubeadm
```
---

6.使用kubeadm初始化集群

```shell
#6.1 使用下面命令初始化集群
tianxuanling@txl-ubuntu-18-10-master0:~$ sudo kubeadm init --kubernetes-version=v1.13.3 --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.100.10
[init] Using Kubernetes version: v1.13.3
[preflight] Running pre-flight checks
	[WARNING Service-Docker]: docker service is not enabled, please run 'systemctl enable docker.service'
error execution phase preflight: [preflight] Some fatal errors occurred:
	[ERROR NumCPU]: the number of available CPUs 1 is less than the required 2
[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`

#6.2 初始化出现问题，按照下面方法处理
# 先执行命令（所有k8s节点）： sudo systemctl enable docker.service
# 再调整CPU数量为2

#6.3 再次初始化集群
tianxuanling@txl-ubuntu-18-10-master0:~$ sudo kubeadm init --kubernetes-version=v1.13.3 --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.100.10
[sudo] password for tianxuanling: 
[init] Using Kubernetes version: v1.13.3
[preflight] Running pre-flight checks
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Activating the kubelet service
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [txl-ubuntu-18-10-master0 kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.100.10]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [txl-ubuntu-18-10-master0 localhost] and IPs [192.168.100.10 127.0.0.1 ::1]
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [txl-ubuntu-18-10-master0 localhost] and IPs [192.168.100.10 127.0.0.1 ::1]
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[apiclient] All control plane components are healthy after 32.011865 seconds
[uploadconfig] storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config-1.13" in namespace kube-system with the configuration for the kubelets in the cluster
[patchnode] Uploading the CRI Socket information "/var/run/dockershim.sock" to the Node API object "txl-ubuntu-18-10-master0" as an annotation
[mark-control-plane] Marking the node txl-ubuntu-18-10-master0 as control-plane by adding the label "node-role.kubernetes.io/master=''"
[mark-control-plane] Marking the node txl-ubuntu-18-10-master0 as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
[bootstrap-token] Using token: pm5pz9.sqamdtcxvaxbrjar
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstraptoken] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstraptoken] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstraptoken] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstraptoken] creating the "cluster-info" ConfigMap in the "kube-public" namespace
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes master has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of machines by running the following on each node
as root:

  kubeadm join 192.168.100.10:6443 --token pm5pz9.sqamdtcxvaxbrjar --discovery-token-ca-cert-hash sha256:cb0943a220e2f28803c894070ba7a60dafaaa973e5949803e3cd45d096963df5

#6.4 初始化完成后分别执行下面命令
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
---

7.安装网络插件canal

```shell
#7.1 使用下面命令安装canal
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/canal/rbac.yaml
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/canal/canal.yaml
```
---

8.查验集群

```shell
#8.1 查验组件状态
tianxuanling@txl-ubuntu-18-10-master0:~$ kubectl get cs
NAME                 STATUS    MESSAGE              ERROR
scheduler            Healthy   ok                   
controller-manager   Healthy   ok                   
etcd-0               Healthy   {"health": "true"}

#8.2 查验命名空间
tianxuanling@txl-ubuntu-18-10-master0:~$ kubectl get ns
NAME          STATUS   AGE
default       Active   54m
kube-public   Active   54m
kube-system   Active   54m

#8.3 查验pod及状态
tianxuanling@txl-ubuntu-18-10-master0:~$ kubectl get pods -n kube-system
NAME                                               READY   STATUS    RESTARTS   AGE
canal-ncbn9                                        3/3     Running   0          35m
coredns-86c58d9df4-kd9d5                           1/1     Running   0          49m
coredns-86c58d9df4-skv2p                           1/1     Running   0          49m
etcd-txl-ubuntu-18-10-master0                      1/1     Running   0          48m
kube-apiserver-txl-ubuntu-18-10-master0            1/1     Running   0          48m
kube-controller-manager-txl-ubuntu-18-10-master0   1/1     Running   0          48m
kube-proxy-9smlj                                   1/1     Running   0          49m
kube-scheduler-txl-ubuntu-18-10-master0            1/1     Running   0          48m
```

---
9.txl-ubuntu-18-10-node0节点加入集群

```shell
#9.1 在txl-ubuntu-18-10-node0节点执行下面命令
tianxuanling@txl-ubuntu-18-10-node0:/etc/docker$ sudo kubeadm join 192.168.100.10:6443 --token pm5pz9.sqamdtcxvaxbrjar --discovery-token-ca-cert-hash sha256:cb0943a220e2f28803c894070ba7a60dafaaa973e5949803e3cd45d096963df5
[preflight] Running pre-flight checks
[discovery] Trying to connect to API Server "192.168.100.10:6443"
[discovery] Created cluster-info discovery client, requesting info from "https://192.168.100.10:6443"
[discovery] Requesting info from "https://192.168.100.10:6443" again to validate TLS against the pinned public key
[discovery] Cluster info signature and contents are valid and TLS certificate validates against pinned roots, will use API Server "192.168.100.10:6443"
[discovery] Successfully established connection with API Server "192.168.100.10:6443"
[join] Reading configuration from the cluster...
[join] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[kubelet] Downloading configuration for the kubelet from the "kubelet-config-1.13" ConfigMap in the kube-system namespace
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Activating the kubelet service
[tlsbootstrap] Waiting for the kubelet to perform the TLS Bootstrap...
[patchnode] Uploading the CRI Socket information "/var/run/dockershim.sock" to the Node API object "txl-ubuntu-18-10-node0" as an annotation

This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the master to see this node join the cluster.

#9.2 然后在txl-ubuntu-18-10-master0执行查验
tianxuanling@txl-ubuntu-18-10-master0:~$ kubectl get nodes
NAME                       STATUS   ROLES    AGE    VERSION
txl-ubuntu-18-10-master0   Ready    master   62m    v1.13.3
txl-ubuntu-18-10-node0     Ready    <none>   9m3s   v1.13.3

#9.3 重新查看node节点加入集群的命令
kubeadm token create --print-join-command
```
---
10.相关命令

```shell
# 查看集群结点状态
kubectl get nodes
# 查看详细结点信息
kubectl describe nodes
# 查看所有pod
kubectl get pods --all-namespaces
# 查看集群服务状态
kubectl get svc --all-namespaces
# 查看集群运行在那些ip上
kubectl cluster-info
# 查看master的各种token
kubectl get secret -n kube-system
# 查看某一个特定的token
kubectl describe secret/[token name] -n kube-system
```
---

到这里，k8s的安装就已经完成了，本节内容就是1个master节点和1个node节点集群的安装，其他相关文章请关注后续，谢谢！
