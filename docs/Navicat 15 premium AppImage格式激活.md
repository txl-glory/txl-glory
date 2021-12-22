# Navicat 15 premium AppImage格式激活

## 相关工具
 - navicat15-premium-cs.AppImage：Navicat 15 premium 官方简体中文试用
 - navicat-patcher：补丁
 - navicat-keygen ：注册机
 - appimagetool-x86_64.AppImage：Linux 独立运行软件打包工具

## 系统环境配置

```shell
# 安装 capstone
sudo apt-get install libcapstone-dev

# 安装 keystone
sudo apt-get install cmake
git clone https://github.com/keystone-engine/keystone.git
cd keystone
mkdir build
cd build
../make-share.sh
sudo make install
sudo ldconfig

# 如果执行 ../make-share.sh 的时候报以下错误
......
variable “CXX” or the CMake cache entry CMAKE_CXX_COMPILER to the full path
......

# 解决方法：
sudo apt-get update
sudo apt-get install -y build-essential

# 安装 rapidjson
sudo apt-get install rapidjson-dev
```

## 激活步骤

```shell
# 赋予执行权限
chmod +x appimagetool-x86_64.AppImage
chmod +x navicat-patcher
chmod +x navicat-keygen

# 解包官方软件
mkdir navicat15
mount -o loop navicat15-premium-cs.AppImage navicat15
cp -r navicat15 navicat15-patched

# 运行补丁
./navicat-patcher navicat15-patched

# 根据提示生成RegPrivateKey.pem文件
**********************************************************
*       Navicat Patcher (Linux) by @DoubleLabyrinth      *
*                  Version: 1.0                          *
**********************************************************
[*] New RSA-2048 private key has been saved to
    ./RegPrivateKey.pem
*******************************************************
*           PATCH HAS BEEN DONE SUCCESSFULLY!         *
*                  HAVE FUN AND ENJOY~                *
*******************************************************

# 打包成独立运行软件
./appimagetool-x86_64.Appimage navicat15-patched navicat15-premium-cs-pathed.AppImage

# 运行补丁后软件包
chmod +x navicat15-premium-cs-pathed.AppImage
./navicat15-premium-cs-pathed.AppImage

# 运行注册机
./navicat-keygen --text ./RegPrivateKey.pem 

# 选择产品类型： 1 Premium
**********************************************************
*       Navicat Keygen (Linux) by @DoubleLabyrinth       *
*                   Version: 1.0                         *
**********************************************************
[*] Select Navicat product:
 0. DataModeler
 1. Premium
 2. MySQL
 3. PostgreSQL
 4. Oracle
 5. SQLServer
 6. SQLite
 7. MariaDB
 8. MongoDB
 9. ReportViewer

(Input index)> 1

# 选择语言： 1 Simplified Chinese
[*] Select product language:
 0. English
 1. Simplified Chinese
 2. Traditional Chinese
 3. Japanese
 4. Polish
 5. Spanish
 6. French
 7. German
 8. Korean
 9. Russian
 10. Portuguese

(Input index)> 1

# 选择版本： 15
[*] Input major version number:
(range: 0 ~ 15, default: 12)> 15

# 生成序列号： 填写至软件注册页面，并在断网后选择手工激活
[*] Serial number:
NAVC-PJWW-BKN4-C4YW
# 填写个人信息：

[*] Your name: 
[*] Your organization: 
# 输入请求码： 复制软件激活页面请求码并粘贴此处然后按两下回车

[*] Input request code in Base64: (Double press ENTER to end)
# 粘贴你的请求码
# 生成激活码： 复制Activation Code内容粘贴至软件激活页面

[*] Request Info:
{"K":"NAVCPJWWBKN4C4YW", "DI":"B0A1C7E8FA226577356B", "P":"linux"}

[*] Response Info:
{"K":"NAVCPJWWBKN4C4YW","DI":"B0A1C7E8FA226577356B","N":"zenghaiming","O":"hh","T":1582448573}

[*] Activation Code:
CKrwYGzMf0OZgZCE***==
```

## 其他

如果提示Are your sure you DO provide a correct private key?，将navicat15-patched目录删除后重新复制一份，再从运行补丁步骤开始执行，多尝试几次。