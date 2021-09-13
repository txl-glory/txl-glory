# Jenkins 自动执行脚本

```shell
cd mms
/home/apache-maven-3.6.3/bin/mvn -s "/home/apache-maven-3.6.3/conf/settings-mms.xml" clean package -Dmaven.test.skip=true
cd target
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/tomcat; sudo docker-compose down"
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/tomcat/webapps; sudo rm -rf ./mms.war"
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/tomcat/webapps; sudo rm -rf ./mms"
scp -P 2222 ./mms.war yfhx@192.168.0.200:/home/yfhx/docker/tomcat/webapps
ssh -p 2222 yfhx@192.168.0.200 "cd /home/yfhx/docker/tomcat; sudo docker-compose up -d"


cd ../../mms-ui
npm config set registry=https://registry.npm.taobao.org
npm install -g cnpm
cnpm install
cnpm run build
ssh -p 2222 yfhx@192.168.0.200 "rm -rf /home/yfhx/docker/tomcat/webapps/jgzg/*"
scp -r -P 2222 ./dist/* yfhx@192.168.0.200:/home/yfhx/docker/tomcat/webapps/jgzg/
```
