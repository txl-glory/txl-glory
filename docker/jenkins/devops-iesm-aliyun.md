# Jenkins 自动执行脚本

```shell
cd IMS-IESM
/home/apache-maven-3.6.3/bin/mvn -s "/home/apache-maven-3.6.3/conf/settings.xml" clean package -Dmaven.test.skip=true
cd target
scp -P 2222 ./IMS-IESM-1.0.0.jar yfhx@192.168.0.200:/home/yfhx/docker/yfhx-iesm/docker-aliyun/image
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/yfhx-iesm/docker-aliyun/image; sudo docker build -t registry.cn-hangzhou.aliyuncs.com/txlhub/yfhx-iesm:1.0.12 ."
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/yfhx-iesm/docker-aliyun/image; sudo docker push registry.cn-hangzhou.aliyuncs.com/txlhub/yfhx-iesm:1.0.12"
ssh -p 22 root@47.113.100.89 "cd /root/docker-xian/ims-iesm; sudo docker-compose down"
ssh -p 22 root@47.113.100.89 "cd /root/docker-xian/ims-iesm; sudo docker rmi registry.cn-hangzhou.aliyuncs.com/txlhub/yfhx-iesm:1.0.12"
ssh -p 22 root@47.113.100.89 "cd /root/docker-xian/ims-iesm; sudo docker-compose up -d"

cd ../../IMS-IESM-WEB
npm config set registry=https://registry.npm.taobao.org
npm install -g cnpm
cnpm install
cnpm run build
ssh -p 2222 yfhx@192.168.0.200 "rm -rf /home/yfhx/docker/nginx-yfhx-iesm/html/iesm/*"
scp -r -P 2222 ./dist/* yfhx@192.168.0.200:/home/yfhx/docker/nginx-yfhx-iesm/html/iesm/
```
