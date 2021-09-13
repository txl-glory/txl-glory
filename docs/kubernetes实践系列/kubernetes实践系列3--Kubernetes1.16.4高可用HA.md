# kubernetes实践系列3--Kubernetes1.16.4高可用HA

在上一篇《kubernetes实践2--安装》里面，我们已经成功搭建了1个master节点和1个node节点的kubernetes集群环境，本章节将在此基础之上主要讨论和部署k8s的高可用HA环境

![image](https://github.com/tianxuanling/kubernetes-in-action/blob/master/images/k8s/k8s-ha.png)

高可用最重要的两个组件：

- etcd：分布式键值存储、k8s集群数据中心。
- kube-apiserver：集群的唯一入口，各组件通信枢纽。apiserver本身无状态，因此分布式很容易。

其它核心组件：

- controller-manager和scheduler也可以部署多个，但只有一个处于活跃状态，以保证数据一致性。因为它们会改变集群状态。

集群各组件都是松耦合的，如何高可用就有很多种方式了。

- kube-apiserver有多个，那么apiserver客户端应该连接哪个了，因此就在apiserver前面加个传统的类似于haproxy+keepalived方案漂个VIP出来，apiserver客户端，比如kubelet、kube-proxy连接此VIP。

## 0. 环境说明

主机名 | IP地址 | 说明
:-:|:-:|:-:
txl-k8s0 | 192.168.1.20 | master节点，keepalived，haproxy 
txl-k8s1 | 192.168.1.21 | master节点，keepalived，haproxy 
txl-k8s2 | 192.168.1.22 | master节点，keepalived，haproxy 
txl-k8s3 | 192.168.1.23 | node节点 
txl-k8s4 | 192.168.1.24 | node节点 
txl-k8s5 | 192.168.1.25 | node节点 
txl-k8s6 | 192.168.1.26 | node节点 

## 1. 基础配置（所有k8s节点）

1.0 apt源配置

```shell
#1.0.1 sources.list文件
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse

deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main

#1.0.2 更新apt源
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg |sudo apt-key add -
sudo apt-get update
```

1.1  同步时区及时间
```shell
sudo tzselect
sudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
sudo ntpdate time.windows.com
tianxuanling@txl-k8s0:/etc$ date -R
Tue, 11 Feb 2020 18:07:41 +0800
```

1.2 配置hosts文件
```shell
192.168.1.20    txl-k8s0
192.168.1.21    txl-k8s1
192.168.1.22    txl-k8s2
192.168.1.23    txl-k8s3
192.168.1.24    txl-k8s4
192.168.1.25    txl-k8s5
192.168.1.26    txl-k8s6
```

1.3 关闭交换空间（所有k8s节点）
```shell
sudo swapoff -a
/etc/fstab文件里面注释掉swap部分
```

1.4 ssh免密（所有k8s节点）
```shell
#1.4.1 生成私钥和公钥,一路回车即可
tianxuanling@txl-k8s0:/etc$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/tianxuanling/.ssh/id_rsa):
Created directory '/home/tianxuanling/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/tianxuanling/.ssh/id_rsa.
Your public key has been saved in /home/tianxuanling/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:RHY4UL/R7iBGeX05vOA/+BPDl8CJhEhVqw5ApHsLSdQ tianxuanling@txl-k8s0
The key's randomart image is:
+---[RSA 2048]----+
|   .ooo+*o+.     |
|  . oE +o= +.. . |
|   o .  +.=.* *  |
|  . o .o ..* * o |
|   + . .S.o o.o .|
|    o ..o. o o+..|
|     .   .  o o+ |
|             ... |
|              .. |
+----[SHA256]-----+

#1.4.2 分发公钥到各k8s节点
ssh-copy-id tianxuanling@txl-k8s0
ssh-copy-id tianxuanling@txl-k8s1
ssh-copy-id tianxuanling@txl-k8s2
ssh-copy-id tianxuanling@txl-k8s3
ssh-copy-id tianxuanling@txl-k8s4
ssh-copy-id tianxuanling@txl-k8s5
ssh-copy-id tianxuanling@txl-k8s6
```

1.5 安装docker并拉取镜像（所有k8s节点）
```shell
#1.5.1 查看docker版本
tianxuanling@txl-k8s0:/etc$ sudo apt show docker.io
Package: docker.io
Version: 18.09.7-0ubuntu1~18.04.4

#1.5.2 安装daocker
sudo apt-get install docker.io

#1.5.3 查看docker版本
tianxuanling@txl-k8s0:/etc$ sudo docker version
Client:
 Version:           18.09.7
 API version:       1.39
 Go version:        go1.10.1
 Git commit:        2d0083d
 Built:             Fri Aug 16 14:20:06 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          18.09.7
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.1
  Git commit:       2d0083d
  Built:            Wed Aug 14 19:41:23 2019
  OS/Arch:          linux/amd64
  Experimental:     false
  
 #1.5.4 查验docker
 tianxuanling@txl-k8s0:/etc$ sudo systemctl status docker.service
● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; disabled; vendor preset: enabled)
   Active: active (running) since Tue 2020-02-11 19:29:44 CST; 1min 20s ago
     Docs: https://docs.docker.com
 Main PID: 2883 (dockerd)
    Tasks: 10
   Memory: 31.4M
   CGroup: /system.slice/docker.service
           └─2883 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
           
#1.5.5 配置docker，在/etc/docker目录下创建daemon.json文件并添加如下内容
# 官方中国区 https://registry.docker-cn.com
# 网易 http://hub-mirror.c.163.com
# 中国科技大学 https://docker.mirrors.ustc.edu.cn
# 阿里云 https://pee6w651.mirror.aliyuncs.com
tianxuanling@txl-k8s0:/etc/docker$ cat daemon.json
{
        "bip" : "20.244.0.1/24",
        "registry-mirrors" : [
                "https://rnxly1wc.mirror.aliyuncs.com",
                "https://docker.mirrors.ustc.edu.cn",
                "http://hub-mirror.c.163.com",
                "http://registry.docker-cn.com"
        ],
        "exec-opts":["native.cgroupdriver=systemd"]
}

#1.5.6 重启docker服务
sudo systemctl daemon-reload
sudo systemctl enable docker.service
sudo systemctl restart docker.service
sudo systemctl status docker.service
```
## 2.安装配置 keepalived（所有master节点）
```shell
# 2.1 安装keepalived
sudo apt-get install keepalived

# 2.2 配置keepalived
tianxuanling@txl-k8s0:/etc/keepalived$ cat keepalived.conf
! Configuration File for keepalived
global_defs {
    notification_email {
        sanhong_zhao@163.com      #发送邮箱
    }
    notification_email_from keepalived@localhost    #邮箱地址
    smtp_server 127.0.0.1   #邮件服务器地址
    smtp_connect_timeout 30
    router_id txl-k8s0         #主机名，每个节点不同即可
    vrrp_mcast_group4 224.0.100.100    #组播地址
}

vrrp_instance VI_1 {
    state MASTER        #在master0上为MASTER,在master1和master2上为BACKUP
    interface ens160    #IP地址漂移到的网卡
    virtual_router_id 6 #多个节点必须相同
    priority 80        #优先级，备用节点的值必须低于主节点的值
    advert_int 1        #通告间隔1秒
    authentication {
        auth_type PASS      #预共享密钥认证
        auth_pass shanhong  #密钥
    }
    virtual_ipaddress {
        192.168.1.240/24    #VIP地址
    }
}

# 2.3 keepalived服务设置及重启
sudo systemctl daemon-reload
sudo systemctl enable keepalived
sudo systemctl restart keepalived
sudo systemctl status keepalived
```

## 3.安装配置 Haproxy（所有master节点）
```shell
# 3.1 安装haproxy
sudo apt-get install haproxy

# 3.2 配置haproxy
tianxuanling@txl-k8s0:/etc/haproxy$ cat haproxy.cfg
global
        log /dev/log    local0
        log /dev/log    local1 notice
        chroot /var/lib/haproxy
        stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
        stats timeout 30s
        user haproxy
        group haproxy
        daemon

        # Default SSL material locations
        ca-base /etc/ssl/certs
        crt-base /etc/ssl/private

        # Default ciphers to use on SSL-enabled listening sockets.
        # For more information, see ciphers(1SSL). This list is from:
        #  https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/
        # An alternative list with additional directives can be obtained from
        #  https://mozilla.github.io/server-side-tls/ssl-config-generator/?server=haproxy
        ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:RSA+AESGCM:RSA+AES:!aNULL:!MD5:!DSS
        ssl-default-bind-options no-sslv3

defaults
        log     global
        mode    http
        option  httplog
        option  dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
        errorfile 400 /etc/haproxy/errors/400.http
        errorfile 403 /etc/haproxy/errors/403.http
        errorfile 408 /etc/haproxy/errors/408.http
        errorfile 500 /etc/haproxy/errors/500.http
        errorfile 502 /etc/haproxy/errors/502.http
        errorfile 503 /etc/haproxy/errors/503.http
        errorfile 504 /etc/haproxy/errors/504.http

frontend k8s-https
    bind *:6443
    mode tcp
    default_backend k8s-https

backend k8s-https
    mode tcp
    balance roundrobin
    server txl-k8s0 192.168.1.20:6443 weight 1 maxconn 1000 check inter 2000 rise 2 fall 3
    server txl-k8s1 192.168.1.21:6443 weight 1 maxconn 1000 check inter 2000 rise 2 fall 3
    server txl-k8s2 192.168.1.22:6443 weight 1 maxconn 1000 check inter 2000 rise 2 fall 3

# 3.3 haproxy服务设置及重启
sudo systemctl daemon-reload
sudo systemctl enable haproxy
sudo systemctl restart haproxy
sudo systemctl status haproxy
```
## 4. k8s相关的docker镜像下载脚本（所有k8s节点）
```shell
# 4.1 Kubernetes几乎所有的安装组件和Docker镜像都放在goolge自己的网站上,直接访问可能会有网络问题，这里的解决办法是从阿里云镜像仓库下载镜像，拉取到本地以后改回默认的镜像tag。本文通过运行image.sh脚本方式拉取镜像。
tianxuanling@txl-k8s0:/etc/kubernetes$ cat image.sh
#!/bin/bash
url=registry.cn-hangzhou.aliyuncs.com/loong576
version=v1.16.4
images=(`kubeadm config images list --kubernetes-version=$version|awk -F '/' '{print $2}'`)
for imagename in ${images[@]} ; do
  docker pull $url/$imagename
  docker tag $url/$imagename k8s.gcr.io/$imagename
  docker rmi -f $url/$imagename
done

# 4.2 执行镜像脚本
sudo bash image.sh

# 4.3 删除所有镜像
sudo docker rmi -f `sudo docker images -q`
```

## 5. k8s集群初始化(HA)

kubeadm配置单master节点集群与配置高可用集群所不同的是，高可用集群给kubeadm一个配置文件，kubeadm根据此文件在多台节点执行init初始化。

```shell
# 5.0 安装kubeadm kubelet kubectl
# 查看版本
sudo apt-cache madison kubeadm
# 卸载
sudo apt-get remove kubeadm kubelet kubectl
# 安装
sudo apt-get install kubeadm=1.16.4-00 kubelet=1.16.4-00 kubectl=1.16.4-00

# 5.1 集群初始化配置文件
sudo bash -c "cat > /etc/kubernetes/kubeadm-config.yaml"  << EOF
apiVersion: kubeadm.k8s.io/v1beta2
kind: ClusterConfiguration
kubernetesVersion: v1.16.4
apiServer:
  certSANs:    #填写所有kube-apiserver节点的hostname、IP、VIP
  - txl-k8s0
  - txl-k8s1
  - txl-k8s2
  - txl-k8s3
  - txl-k8s4
  - txl-k8s5
  - txl-k8s6
  - 192.168.1.20
  - 192.168.1.21
  - 192.168.1.22
  - 192.168.1.23
  - 192.168.1.24
  - 192.168.1.25
  - 192.168.1.26
  - 192.168.1.240
controlPlaneEndpoint: "192.168.1.240:6443"
networking:
  podSubnet: "10.0.0.0/16"
EOF

# 5.2 k8s集群初始化
sudo kubeadm init --config ./kubeadm-config.yaml

# 5.3 如果初始化失败，可执行kubeadm reset后重新初始化
sudo kubeadm reset

# 5.4 记录kubeadm join的输出，后面需要这个命令将work节点和其他control plane节点加入集群中。
You can now join any number of control-plane nodes by copying certificate authorities
and service account keys on each node and then running the following as root:

  kubeadm join 192.168.1.240:6443 --token mszl4u.hkjntdpckq0rwxyq \
    --discovery-token-ca-cert-hash sha256:def7afdaef2080f306d785bdbd3d0687e651a6c7349d87ed5a8864f515391774 \
    --control-plane

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.1.240:6443 --token mszl4u.hkjntdpckq0rwxyq \
    --discovery-token-ca-cert-hash sha256:def7afdaef2080f306d785bdbd3d0687e651a6c7349d87ed5a8864f515391774
    
# 5.5 执行如下命令
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 5.6 安装flannel网络
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# 由于网络原因，需要手动拉去镜像
sudo docker pull quay-mirror.qiniu.com/coreos/flannel:v0.11.0-amd64
sudo docker tag quay-mirror.qiniu.com/coreos/flannel:v0.11.0-amd64 quay.io/coreos/flannel:v0.11.0-amd64
```

## 6. control plane节点加入k8s集群
```shell
# 6.1 分发证书,在txl-k8s0上运行脚本cert-main-master.sh，将证书分发至txl-k8s1和txl-k8s2
tianxuanling@txl-k8s0:/etc/kubernetes$ cat cert-main-master.sh
USER=tianxuanling # customizable
CONTROL_PLANE_IPS="192.168.1.21 192.168.1.22"
for host in ${CONTROL_PLANE_IPS}; do
    scp /etc/kubernetes/pki/ca.crt "${USER}"@$host:
    scp /etc/kubernetes/pki/ca.key "${USER}"@$host:
    scp /etc/kubernetes/pki/sa.key "${USER}"@$host:
    scp /etc/kubernetes/pki/sa.pub "${USER}"@$host:
    scp /etc/kubernetes/pki/front-proxy-ca.crt "${USER}"@$host:
    scp /etc/kubernetes/pki/front-proxy-ca.key "${USER}"@$host:
    scp /etc/kubernetes/pki/etcd/ca.crt "${USER}"@$host:etcd-ca.crt
    # Quote this line if you are using external etcd
    scp /etc/kubernetes/pki/etcd/ca.key "${USER}"@$host:etcd-ca.key
done

# 执行脚本
sudo bash cert-main-master.sh

# 6.2 txl-k8s1移动证书至指定目录
tianxuanling@txl-k8s1:/etc/kubernetes$ cat cert-other-master.sh
USER=/home/tianxuanling # customizable
mkdir -p /etc/kubernetes/pki/etcd
mv /${USER}/ca.crt /etc/kubernetes/pki/
mv /${USER}/ca.key /etc/kubernetes/pki/
mv /${USER}/sa.pub /etc/kubernetes/pki/
mv /${USER}/sa.key /etc/kubernetes/pki/
mv /${USER}/front-proxy-ca.crt /etc/kubernetes/pki/
mv /${USER}/front-proxy-ca.key /etc/kubernetes/pki/
mv /${USER}/etcd-ca.crt /etc/kubernetes/pki/etcd/ca.crt
# Quote this line if you are using external etcd
mv /${USER}/etcd-ca.key /etc/kubernetes/pki/etcd/ca.key

# 执行脚本
sudo bash cert-other-master.sh

# 6.3 txl-k8s2移动证书至指定目录
tianxuanling@txl-k8s2:/etc/kubernetes$ cat cert-other-master.sh
USER=/home/tianxuanling # customizable
mkdir -p /etc/kubernetes/pki/etcd
mv /${USER}/ca.crt /etc/kubernetes/pki/
mv /${USER}/ca.key /etc/kubernetes/pki/
mv /${USER}/sa.pub /etc/kubernetes/pki/
mv /${USER}/sa.key /etc/kubernetes/pki/
mv /${USER}/front-proxy-ca.crt /etc/kubernetes/pki/
mv /${USER}/front-proxy-ca.key /etc/kubernetes/pki/
mv /${USER}/etcd-ca.crt /etc/kubernetes/pki/etcd/ca.crt
# Quote this line if you are using external etcd
mv /${USER}/etcd-ca.key /etc/kubernetes/pki/etcd/ca.key

# 执行脚本
sudo bash cert-other-master.sh

# 6.4 txl-k8s1和txl-k8s2加入k8s集群（Master节点）
sudo kubeadm join 192.168.1.240:6443 --token mszl4u.hkjntdpckq0rwxyq \
    --discovery-token-ca-cert-hash sha256:def7afdaef2080f306d785bdbd3d0687e651a6c7349d87ed5a8864f515391774 \
    --control-plane
    
# 6.5 txl-k8s3,txl-k8s4,txl-k8s5,txl-k8s6加入k8s集群（work节点）
sudo kubeadm join 192.168.1.240:6443 --token mszl4u.hkjntdpckq0rwxyq \
    --discovery-token-ca-cert-hash sha256:def7afdaef2080f306d785bdbd3d0687e651a6c7349d87ed5a8864f515391774
```
## 7. k8s集群查验
```shell
tianxuanling@txl-k8s0:/etc$ kubectl get node
NAME       STATUS   ROLES    AGE   VERSION
txl-k8s0   Ready    master   33h   v1.16.4
txl-k8s1   Ready    master   33h   v1.16.4
txl-k8s2   Ready    master   33h   v1.16.4
txl-k8s3   Ready    <none>   32h   v1.16.4
txl-k8s4   Ready    <none>   32h   v1.16.4
txl-k8s5   Ready    <none>   32h   v1.16.4
txl-k8s6   Ready    <none>   32h   v1.16.4
tianxuanling@txl-k8s0:/etc$ kubectl get pod -o wide -n kube-system
NAME                               READY   STATUS    RESTARTS   AGE   IP             NODE       NOMINATED NODE   READINESS GATES
coredns-5644d7b6d9-dhg8j           1/1     Running   2          33h   10.0.0.7       txl-k8s0   <none>           <none>
coredns-5644d7b6d9-n425z           1/1     Running   2          33h   10.0.0.6       txl-k8s0   <none>           <none>
etcd-txl-k8s0                      1/1     Running   2          33h   192.168.1.20   txl-k8s0   <none>           <none>
etcd-txl-k8s1                      1/1     Running   2          33h   192.168.1.21   txl-k8s1   <none>           <none>
etcd-txl-k8s2                      1/1     Running   2          33h   192.168.1.22   txl-k8s2   <none>           <none>
kube-apiserver-txl-k8s0            1/1     Running   2          33h   192.168.1.20   txl-k8s0   <none>           <none>
kube-apiserver-txl-k8s1            1/1     Running   2          33h   192.168.1.21   txl-k8s1   <none>           <none>
kube-apiserver-txl-k8s2            1/1     Running   3          33h   192.168.1.22   txl-k8s2   <none>           <none>
kube-controller-manager-txl-k8s0   1/1     Running   3          33h   192.168.1.20   txl-k8s0   <none>           <none>
kube-controller-manager-txl-k8s1   1/1     Running   2          33h   192.168.1.21   txl-k8s1   <none>           <none>
kube-controller-manager-txl-k8s2   1/1     Running   2          33h   192.168.1.22   txl-k8s2   <none>           <none>
kube-flannel-ds-amd64-4h95g        1/1     Running   4          32h   192.168.1.26   txl-k8s6   <none>           <none>
kube-flannel-ds-amd64-cgfdp        1/1     Running   4          33h   192.168.1.20   txl-k8s0   <none>           <none>
kube-flannel-ds-amd64-ffjgb        1/1     Running   5          33h   192.168.1.21   txl-k8s1   <none>           <none>
kube-flannel-ds-amd64-lhp7x        1/1     Running   4          32h   192.168.1.24   txl-k8s4   <none>           <none>
kube-flannel-ds-amd64-r52xp        1/1     Running   3          33h   192.168.1.22   txl-k8s2   <none>           <none>
kube-flannel-ds-amd64-x4w4l        1/1     Running   4          32h   192.168.1.25   txl-k8s5   <none>           <none>
kube-flannel-ds-amd64-xx7wk        1/1     Running   4          32h   192.168.1.23   txl-k8s3   <none>           <none>
kube-proxy-8n569                   1/1     Running   2          32h   192.168.1.24   txl-k8s4   <none>           <none>
kube-proxy-8x2fv                   1/1     Running   2          32h   192.168.1.23   txl-k8s3   <none>           <none>
kube-proxy-kghb2                   1/1     Running   2          33h   192.168.1.21   txl-k8s1   <none>           <none>
kube-proxy-m84hb                   1/1     Running   2          33h   192.168.1.20   txl-k8s0   <none>           <none>
kube-proxy-n7psx                   1/1     Running   2          32h   192.168.1.25   txl-k8s5   <none>           <none>
kube-proxy-qdl7p                   1/1     Running   2          32h   192.168.1.26   txl-k8s6   <none>           <none>
kube-proxy-zqgtm                   1/1     Running   2          33h   192.168.1.22   txl-k8s2   <none>           <none>
kube-scheduler-txl-k8s0            1/1     Running   3          33h   192.168.1.20   txl-k8s0   <none>           <none>
kube-scheduler-txl-k8s1            1/1     Running   2          33h   192.168.1.21   txl-k8s1   <none>           <none>
kube-scheduler-txl-k8s2            1/1     Running   2          33h   192.168.1.22   txl-k8s2   <none>           <none>
```