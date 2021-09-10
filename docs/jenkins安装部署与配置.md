# jenkins 安装部署与配置

## 0. 基础环境准备


| 0.1 安装环境表 |
| 名称 | 版本 | 描述 |
| :---: | :----: | :---: |
| 操作系统 | Ubuntu 20.04 LTS | 操作系统 |
| jenkins | image: jenkins/jenkins:2.249.3-lts-centos7 | 持续集成工具 |
| docker.io | 20.10.7-0ubuntu1~20.04.1 | docker容器服务(- docker-ce 是 docker 官方维护的 - docker.io 是 Debian 团队维护的) |
| docker-compose | 1.25.0-1 | docker容器编排 |

```
# File Header
/**
 * description: ${NAME} <br>
 * date: ${DATE} ${TIME} <br>
 * author: zhaosh <br>
 */

 # Live Templates
 *
  * description: $description$ <br>
  * date: $date$ $time$ <br>
  * author: zhaosh <br>
  $params$
  * @return $return$
  **/

  # description ： methodName()
  # params ： groovyScript("def result=''; def params=\"${_1}\".replaceAll('[\\\\[|\\\\]|\\\\s]', '').split(',').toList(); for(i = 0; i < params.size(); i++) {result+=' * @param ' + params[i] + ((i < params.size() - 1) ? '\\n' : '')}; return result", methodParameters())
  # return ： methodReturnType()
```
