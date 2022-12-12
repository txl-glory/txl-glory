# parallels desktop 解决网络初始化失败问题

终端执行命令：sudo vim /Library/Preferences/Parallels/network.desktop.xml

注：查看第五行<Usekextless>?<Usekextless>中间的值是多少，可能是1，可能是-1，改成0，保存，如果没有这行的话，彻底删除parallels desktop在重新安装就可以，一开始我始终就没有这行，直接删除是不没用的，需要彻底删除，清理配置文件，在安装改下这个参数就可以了，重新启动就可以了。