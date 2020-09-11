# 问题处理

## 1.中文乱码问题
在用户界面把文字改为中文后，虽然界面上变成了中文，但是在graph图形页面上有乱码，如下图所示：

![](https://github.com/tianxuanling/txl-glory/blob/master/docker/zabbix/images/luanma.png)

解决方法：把本地字体文件复制到容器中去。

1. 控制面板–>字体–>选择一种中文字库例如“楷体”（simkai.ttf），把这个字体拿到运行zabbix容器的宿主机上。
2. 把字体复制到apache和nginx容器中：

```bash
docker cp ~/simkai.ttf zabbix-docker_zabbix-web-nginx-mysql_1:/usr/share/zabbix/fonts/
docker cp ~/simkai.ttf zabbix-docker_zabbix-web-apache-mysql_1:/usr/share/zabbix/fonts/
```

进入docker容器，执行：

```bash
cd /usr/share/zabbix/fonts
ln -snf simkai.ttf graphfont.ttf
```
不需要重启，再次查看，乱码已经显示正常。
