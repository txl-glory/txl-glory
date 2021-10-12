# nginx配置自签名https
nginx配置https是需要CA颁发证书的，为了测试方便，我们可以使用自签名证书

## 一： 如何生成自签名证书

### 1.1 我们需要为服务端和客户端准备私钥和公钥

```shell
//生成服务器端私钥
openssl genrsa -out server.key 2048
//生成服务器端公钥
openssl rsa -in server.key -pubout -out server.pem
```

### 1.2 生成CA证书

```shell
// 生成 CA 私钥
openssl genrsa -out ca.key 1024

openssl req -new -key ca.key -out ca.csr

# 注意:执行上面命令会出现以下需要填写的项目，可以直接回车跳过，但是Common Name那一项建议填写你的域名，如果是本地的话，可以写localhost

Country Name (2 letter code) [AU]:
State or Province Name (full name) [Some-State]:
Locality Name (eg, city) []:
Organization Name (eg, company) [Internet Widgits Pty Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:这个是你的域名
Email Address []:

// 生成CA证书
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt
```

### 1.3 生成服务器证书

```shell
//服务器端需要向 CA 机构申请签名证书，在申请签名证书之前依然是创建自己的 CSR 文件
openssl req -new -key server.key -out server.csr
//向自己的 CA 机构申请证书，签名过程需要 CA 的证书和私钥参与，最终颁发一个带有 CA 签名的证书
openssl x509 -req -CA ca.crt -CAkey ca.key -CAcreateserial -in server.csr -out server.crt
```

### 1.4 生成cer文件
```shell
//使用openssl 进行转换
openssl x509 -in server.crt -out server.cer -outform der
```

## 配置nginx
我们拿到CA签发的这个证书后，需要将证书配置在nginx中。
首先，我们将server.crt和server.key拷贝到nginx的配置文件所在的目录
其次，在nginx的配置中添加如下配置：

```shell
http{
  server {
        listen       443 ssl;
        server_name  你的域名;
        charset utf-8;

        ssl on;
        ssl_certificate      server.crt;
        ssl_certificate_key  server.key;

        location / {
            root   /var/www/html;
            index  index.html index.htm;
        }
    }
}
```
当前我们只是做一个欢迎页的https测试，所以location用的是默认的。需要扩展的小伙伴可以自行修改配置。
最后，重启nginx，访问https://你的域名，便可出现欢迎页。

注意：很多时候，访问一个网站的时候不会刻意去加https开头，而是直接输入域名访问，但是这样浏览器默认是http请求，如何让用户直接输入域名访问的也是https请求呢？
方法1:将所有http请求重定向到https

```shell
server { 
        charset utf-8;
        listen 80; 
        server_name 你的域名;
        rewrite ^(.*) https://$host$1 permanent;
    }
```
方法2:当网站只允许https访问的时候，通过http访问会报497状态码，利用error_page的方式重定向到https
```shell
server {
        listen       443 ssl;
        listen       80;
        server_name  localhost;
        charset utf-8;

        ssl on;
        ssl_certificate      server.crt;
        ssl_certificate_key  server.key;

        location / {
            root   html;
            index  index.html index.htm;
        }

        error_page 497  https://$host$uri?$args;
    }
```

方法3:利用浏览器的方式
首先，建一个html文本，命名为https.html
```shell
html>  
<meta http-equiv="refresh" content="0;url=https://你的域名/">  
</html>
```
其次，再通过配置监听80端口的server对该html访问：
```shell
server {
        charset utf-8;
        listen 80; 
        server_name 你的域名;
        location / {
            root html;
            index https.html;
        }
        error_page 404 https://你的域名/;
    }
```
