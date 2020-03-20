# docker 命令相关笔记

## docker ps 显示指定的列
docker ps 默认的显示内容过多，当值过长时就会导致折行，可读性很差，所以希望只显示自己关心的某些列。

可以自己指定显示的模板，例如：
```shell script
sudo docker ps --format "table {{.ID}}\t{{.RunningFor}}\t{{.Names}}\t{{.Ports}}\t{{.Image}}"


# 可用的占位符
名称	含义
.ID	容器ID
.Image	镜像ID
.Command	执行的命令
.CreatedAt	容器创建时间
.RunningFor	运行时长
.Ports	暴露的端口
.Status	容器状态
.Names	容器名称
.Label	分配给容器的所有标签
.Mounts	容器挂载的卷
.Networks	容器所用的网络名称
```