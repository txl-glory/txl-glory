# kubernetes实践系列99--k8s集群部分常见问题处理
目录
部分常见问题处理

Coredns CrashLoopBackOff 导致无法成功添加工作节点的问题

添加工作节点时提示token过期

kubectl 执行命令报“The connection to the server localhost:8080 was refused”

网络组件flannel无法完成初始化

部分节点无法启动pod 

最后

## 1.Coredns CrashLoopBackOff 导致无法成功添加工作节点的问题
k8s集群安装完成之后，当我们添加工作节点时，可能会在长久的等待之中而无任何进展，这时可以使用以下命令来查看k8s各个服务的状态：
```shell
kubectl get pods -n kube-system -o wide
```

![image](https://raw.githubusercontent.com/txl-glory/txl-glory/master/docs/images/k8s/coredns-CrashLoopBackOff.png)