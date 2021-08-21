# Jenkins 自动执行脚本

```shell
cd IMS-IESM
/home/apache-maven-3.6.3/bin/mvn -s "/home/apache-maven-3.6.3/conf/settings.xml" clean package -Dmaven.test.skip=true
cd target
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/yfhx-iesm/docker-prod; sudo docker-compose down"
scp -P 2222 ./IMS-IESM-1.0.0.jar yfhx@192.168.0.200:/home/yfhx/docker/yfhx-iesm/docker-prod
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/yfhx-iesm/docker-prod; sudo docker build -t txl/iesm-prod:1.0.0 ."
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/yfhx-iesm/docker-prod; sudo docker-compose up -d"

cd ../../IMS-IESM-WEB
npm config set registry=https://registry.npm.taobao.org
npm install -g cnpm
cnpm install
cnpm run build
ssh -p 2222 yfhx@192.168.0.200 "rm -rf /home/yfhx/docker/nginx-yfhx-iesm/html/iesm/*"
scp -r -P 2222 ./dist/* yfhx@192.168.0.200:/home/yfhx/docker/nginx-yfhx-iesm/html/iesm/
```
