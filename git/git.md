# Git设置

初次运行 Git 前的配置
一般在新的系统上，我们都需要先配置下自己的 Git 工作环境。配置工作只需一次，以后升级时还会沿用现在的配置。当然，如果需要，你随时可以用相同的命令修改已有的配置。

## 设置用户名和邮箱（必须设置）

在命令行里输入以下命令来添加用户名和 Email ，这个信息将用在后续你的每一次 Git 提交里。

```bash
git config --global user.name "Your Name"      # 请替换你的用户名
git config --global user.email "your@email"      # 请替换你自己的公司邮箱
```

## 设置命令别名

Git 允许用户配置别名命令，简化命令行操作，也可以让客户沿用以前使用其他版本控制工具的习惯。例如如下命令创建和 SVN 兼容的命令：

```bash
git config --global alias.st status
git config --global alias.ci "commit -s"
git config --global alias.co checkout
git config --global alias.br branch
```

## 中文惯用设置

为了支持能够正确显示带中文的目录、文件，启用如下设置：

```bash
git config --global core.quotepath false
```

## 其他设置

系统安装的 Git 通常会启用带颜色输出：

```bash
sudo git config --system color.ui auto
```

执行合并操作时，自动生成的合并提交说明中包含源分支的精简提交说明：

```bash
git config --global merge.log true
```

执行交互式变基操作时，自动将带有 “fixup!” 前缀的提交压缩（squash）到匹配的提交上。

```bash
git config --global rebase.autosquash true
```

## 查看配置

以上设置执行完成后，可以通过以下命令查看是否配置正确。
```bash
git config --global --list
```

# 常见问题处理

## fatal: early EOF fatal: index-pack failed

可以将这些行添加到全局git配置文件.gitconfig中，这个文件在用户家目录下

```config
[user]
	name = xxxx
	email = xxxx@admin.com
[http]
	postBuffer = 1048576000
	lowSpeedLimit = 0
	lowSpeedTime = 999999
[core]
	compression = 0
[pack] 
	deltaCacheSize = 2047m
	packSizeLimit = 2047m
	windowMemory = 2047m
```