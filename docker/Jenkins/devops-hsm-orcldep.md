# Jenkins 自动执行脚本

git@192.168.0.200:yfhx/hsm.git

H/5 * * * *

```shell
/home/apache-maven-3.6.3/bin/mvn -s "/home/apache-maven-3.6.3/conf/settings.xml" clean package -Dmaven.test.skip=true
cd hsm-admin/target/
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/hsm/orcldep; sudo docker-compose down"
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/hsm/orcldep/image; sudo rm -rf ./hsm-boot.jar"
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/hsm/orcldep/image; sudo docker rmi -f registry.cn-hangzhou.aliyuncs.com/txlhub/hsm:1.0.0 "
scp -P 2222 ./hsm-boot.jar yfhx@192.168.0.200:/home/yfhx/docker/hsm/orcldep/image
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/hsm/orcldep/image; sudo docker build -t registry.cn-hangzhou.aliyuncs.com/txlhub/hsm:1.0.0 ."
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/hsm/orcldep; sudo docker-compose up -d"


cd ../../hsm-ui
npm config set registry=https://registry.npm.taobao.org
npm install -g cnpm
cnpm install
cnpm run build:prod
ssh -p 2222 yfhx@192.168.0.200 "rm -rf /home/yfhx/docker/nginx/html/zyjk/*"
scp -r -P 2222 ./dist/* yfhx@192.168.0.200:/home/yfhx/docker/nginx/html/zyjk/
```
