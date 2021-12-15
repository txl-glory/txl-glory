# git clone early EOF error 的解决方式

## 1.在我遇到的这个错误的原因应该是文件太大,解决方式为git添加 compression 配置项

解决办法：git config --global core.compression -1

compression 是压缩的意思，从 clone 的终端输出就知道，服务器会压缩目标文件，然后传输到客户端，客户端再解压。取值为 [-1, 9]，-1 以 zlib 为默认压缩库，0 表示不进行压缩，1..9 是压缩速度与最终获得文件大小的不同程度的权衡，数字越大，压缩越慢，当然得到的文件会越小。

## 2.可以增加git的缓存大小

git config --global http.postBuffer 1048576000

将http.postBuffer设置的尽量大，例如git config --global http.postBuffer 524288000 （500M）
git config --global http.postBuffer 1048576000 (1G)。再大的应该是依次类推吧
因为下载的时候不止是工程数据，还有其它配置数据，总量会大于工程数据量，所以设置的缓存大小一定要比工程大小多一些。

## 3.配置git的最低速和最低速时间

git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999 单位 秒