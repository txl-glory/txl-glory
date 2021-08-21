# mapbox环境部署

1. mysql数据库环境搭建，导入pie_lbs.sql数据文件。
2. mongodb环境搭建，导入task_tracks.json数据文件。
3. postgres环境搭建，导入kong.sql数据文件。
4. 启动kong镜像服务。
5. 启动kong-dashboard镜像服务。
6. 相关镜像190612下面push的所有配置文件修改及部署。
7. 部署operationmanage服务。
8. 部署dist服务到tomcat。
9. 配置kong的服务代理路由。
10. 部署map服务。