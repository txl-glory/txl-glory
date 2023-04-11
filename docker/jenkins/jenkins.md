```shel
if [ "${BUILD_TYPE}"x = "RELEASE"x ]; then
#  ${MAVEN_BIN}/mvn -v
  ${MAVEN_BIN}/mvn -U clean install -Dmaven.test.skip=true
  ${MAVEN_BIN}/mvn deploy -Dmaven.test.skip=true
  cd ${WORKSPACE}/cnnit-ui
  rm -rf dist
  rm -rf dist.tar.gz
  npm install
  npm run build:prod
  tar -zcvf dist.tar.gz ./dist
else
  echo "ERROR"
fi  

**/target/cnnit-*.jar,**/Dockerfile,cnnit-modules/cnnit-iems/target/classes/doc/**/*.*,cnnit-ui/dist.tar.gz,cnnit-ui/docker/*.*,cicd/**/*.*

cd /usr/local/share/cicd/${JOB_BASE_NAME}
echo $(pwd)

rm -rf ./cnnit-ui/docker/dist
tar -zxvf ./cnnit-ui/dist.tar.gz -C ./cnnit-ui/docker/

docker build -t cnnit-auth:${BUILD_TAG} ./cnnit-auth
docker tag cnnit-auth:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-auth:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-auth:${BUILD_TAG}
docker image prune -f

docker build -t cnnit-gateway:${BUILD_TAG} ./cnnit-gateway
docker tag cnnit-gateway:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-gateway:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-gateway:${BUILD_TAG}
docker image prune -f

docker build -t cnnit-gen:${BUILD_TAG} ./cnnit-modules/cnnit-gen
docker tag cnnit-gen:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-gen:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-gen:${BUILD_TAG}
docker image prune -f

docker build -t cnnit-job:${BUILD_TAG} ./cnnit-modules/cnnit-job
docker tag cnnit-job:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-job:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-job:${BUILD_TAG}
docker image prune -f

docker build -t cnnit-file:${BUILD_TAG} ./cnnit-modules/cnnit-file
docker tag cnnit-file:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-file:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-file:${BUILD_TAG}
docker image prune -f

docker build -t cnnit-di:${BUILD_TAG} ./cnnit-modules/cnnit-di
docker tag cnnit-di:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-di:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-di:${BUILD_TAG}
docker image prune -f

docker build -t cnnit-kdl:${BUILD_TAG} ./cnnit-modules/cnnit-kdl
docker tag cnnit-kdl:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-kdl:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-kdl:${BUILD_TAG}
docker image prune -f

docker build -t cnnit-expl:${BUILD_TAG} ./cnnit-modules/cnnit-expl
docker tag cnnit-expl:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-expl:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-expl:${BUILD_TAG}
docker image prune -f

docker build -t cnnit-bpm:${BUILD_TAG} ./cnnit-modules/cnnit-bpm
docker tag cnnit-bpm:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-bpm:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-bpm:${BUILD_TAG}
docker image prune -f

docker build -t cnnit-bpm:${BUILD_TAG} ./cnnit-modules/cnnit-bpm
docker tag cnnit-bpm:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-bpm:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-bpm:${BUILD_TAG}
docker image prune -f

docker build -t cnnit-iems:${BUILD_TAG} ./cnnit-modules/cnnit-iems
docker tag cnnit-iems:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-iems:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-iems:${BUILD_TAG}
docker image prune -f

docker build -t cnnit-system:${BUILD_TAG} ./cnnit-modules/cnnit-system
docker tag cnnit-system:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-system:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-system:${BUILD_TAG}
docker image prune -f

docker build -t cnnit-monitor:${BUILD_TAG} ./cnnit-visual/cnnit-monitor
docker tag cnnit-monitor:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-monitor:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-monitor:${BUILD_TAG}
docker image prune -f

docker build -t cnnit-nginx:${BUILD_TAG} ./cnnit-ui/docker
docker tag cnnit-nginx:${BUILD_TAG}  cnnit-dockerhub:8082/cnnit-iems/cnnit-nginx:${BUILD_TAG}
docker login cnnit-dockerhub:8082 -u admin -p Caini@123
docker push cnnit-dockerhub:8082/cnnit-iems/cnnit-nginx:${BUILD_TAG}
docker image prune -f
```

