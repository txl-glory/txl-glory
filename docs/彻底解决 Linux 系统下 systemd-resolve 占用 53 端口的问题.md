# 彻底解决 Linux 系统下 systemd-resolve 占用 53 端口的问题

```
## 查看端口占用情况，看看 53 端口是不是被 systemd-resolved 占用了。
sudo netstat -nultp
如果 53 端口确定被 systemd-resolved 占用了，则可以根据下面给出的方法解决。

# 1. 先停用 systemd-resolved 服务。
sudo systemctl stop systemd-resolved

# 2. 编辑 /etc/systemd/resolved.conf 文件，按 “i” 键进入编辑模式。
sudo vi /etc/systemd/resolved.conf

# 3. 换下面说明更改，然后按一下 “esc” 键，再输入 “:wq”（不要输入引号），回车保存即可。
[Resolve]
DNS=223.5.5.5         #取消注释，增加dns
#FallbackDNS=
#Domains=
#LLMNR=no
#MulticastDNS=no
#DNSSEC=no
#DNSOverTLS=no
#Cache=no-negative
DNSStubListener=no    #取消注释，把yes改为no
#ReadEtcHosts=yes

# 4. 最后运行下面命令即可。
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
```