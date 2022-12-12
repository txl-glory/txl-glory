# Docker搭建openvpn

## docker-compose.yml文件

```yml
version: '3.8'
services:
  openvpn: 
    image: kylemanna/openvpn:2.4
    container_name: openvpn
    restart: always
    network_mode: 'bridge'
    environment:
      TZ: 'Asia/Shanghai'
    ports:
      - 1194:1194/udp
    volumes:
      - ./data/openvpn:/etc/openvpn
    cap_add: 
      - NET_ADMIN
```

## 配置openvpn容器
docker-compose run --rm openvpn ovpn_genconfig -u udp://ip
ip为公网IP地址

## 初始化
docker-compose run --rm openvpn ovpn_initpki
按提示输入，回车。

## 启动openvpn
docker-compose up -d openvpn

## 创建用户jack客户端文件
docker-compose run --rm openvpn easyrsa build-client-full jack nopass
docker-compose run --rm openvpn ovpn_getclient jack > ./jack.ovpn

## 删除用户jack
docker-compose run --rm openvpn easyrsa revoke jack
docker-compose run --rm openvpn easyrsa gen-crl update-db
docker-compose restart

下载openvpn客户端，直接导入.ovpn文件即可使用。