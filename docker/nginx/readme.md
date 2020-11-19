# centos7 安装 nginx

## 1.nginx 安装过程

```bash
# 1.添加yum源
rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-ce

# 2.安装nginx
yum install -y nginx

# 3.启动nginx
/usr/sbin/nginx

# 4.关闭nginx
/usr/sbin/nginx -s stop

# 5.重启nginx
/usr/sbin/nginx -s reload
```

## 2./etc/nginx/nginx.conf 配置文件

```conf
#user  nobody;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    server {
        listen       90;
        server_name  192.168.0.162;

        location / {
            root   html;
            index  index.html index.htm;
        }

        location /iesm-jt/IMS-IESM/ {
            proxy_pass  http://192.168.0.162:9041/IMS-IESM/;
            proxy_set_header           Host $host;
            proxy_set_header  X-Real-IP  $remote_addr;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
            client_max_body_size  100m;
            index  index.html index.htm;
        }
    }
}
```
