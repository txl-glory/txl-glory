# Git 设置

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

## git config pull.rebase后面加true和false的区别。
在 Git 中，git pull 命令用于从远程仓库拉取最新的代码，并自动合并到本地分支中。默认情况下，git pull 命令执行的是 "merge" 操作，即将远程分支的代码合并到本地分支中。

在 Git 中还有另一种合并方式，称为 "rebase"。通过 git config pull.rebase 命令可以配置 git pull 命令的默认行为，以决定执行 "merge" 还是 "rebase" 操作。

当执行 git config pull.rebase true 命令时，表示在执行 git pull 命令时默认使用 "rebase" 操作。这种操作会将本地分支的修改应用于远程分支的基础之上，从而保持提交历史的线性，避免了 "merge" 操作带来的额外的合并提交。但是，使用 "rebase" 操作也可能导致代码冲突和修改历史被覆盖的问题，因此需要谨
慎使用。

当执行 git config pull.rebase false 命令时，表示在执行 git pull 命令时默认使用 "merge" 操作。这种操作会将远程分支的代码合并到本地分支中，并且会创建一个新的合并提交，将两个分支的修改合并在一起，保留了分支的提交历史。

通常情况下，"merge" 操作比 "rebase" 操作更加安全和易于理解。

因此，设置 pull.rebase 为 true 或 false 的区别在于 git pull 命令执行的合并方
式。根据具体情况和需求选择合适的合并方式。
```bash
git config pull.rebase false： #这是默认的合并策略，它会在本地创建一个新的合并提交，将本地分支和远程分支合并在一起。这种策略会保留分支历史，但可能会产生一些不必要的合并提交。
git config pull.rebase true： #这是将本地提交“变基”到远程分支的策略。这意味着将本地提交应用到远程分支之上，以便使得历史记录更加线性，不会产生合并提交。但是，变基操作可能会更改提交的SHA值，因此可能会破坏其他人的工作，需要谨慎使用。
git config pull.ff only： #这个选项只会允许快进合并，也就是只有在本地分支的提交历史是远程分支的子集时才会自动合并。这种策略会保持线性历史，并且不会创建任何新的提交。但是，这种策略可能会导致某些提交丢失，因为快进合并可能会覆盖本地提交。
```

## 永久记住密码 (全局)

```shell
git config --global credential.helper store

## 会在~/.gitconfig文件中生成下面的配置。
[credential]
	helper = store
```

## 临时记住密码

```shell
## 默认记住15分钟：
git config –global credential.helper cache

## 下面是自定义配置记住1小时：
git config credential.helper ‘cache –timeout=3600’
```

## 查看配置

以上设置执行完成后，可以通过以下命令查看是否配置正确。

```bash
git config --global --list
```

## git 拉取所有远程分支

```shell
git clone xxx
git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
git fetch --all
git pull --all
```


# 常见问题处理

## fatal: early EOF fatal: index-pack failed

可以将这些行添加到全局 git 配置文件.gitconfig 中，这个文件在用户家目录下

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
