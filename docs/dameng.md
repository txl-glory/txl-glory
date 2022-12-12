# 达梦数据库相关

## 大小写不敏感

通过命令行 dminit 工具初始化实例，通过参数 case_sensitive 进行设置，参数默认值为 Y （即为 1 ），也就是敏感（区分大小写），如果要设置为不敏感，参数设置【case_sensitive=n 】或者【case_sensitive=0 】即可（参数名字大写或者小写都可以）
/opt/dmdbms/bin/dminit

## 后台启动，一般建议用后台启动

nohup ./dmserver /home/dmdba/dmdata/DAMENG/dm.ini &

## 前台启动（关闭窗口，数据库会关闭）

./dmserver /home/dmdba/dmdata/DAMENG/dm.ini
