---
title: 在 Ubuntu 下搭建 Git 环境并简单使用
date: '2015-01-12T00:00:00.000Z'
description: 指导如何在 Ubuntu 操作系统中搭建 Git 环境并实现与 GitHub 的基础交互。内容涵盖 Git 的安装、全局用户配置、SSH 密钥生成与 GitHub 绑定，以及标准的代码提交流程（克隆、修改、暂存、提交、推送）和常用分支管理命令。
tags:
  - Git
  - GitHub
  - Ubuntu
categories:
  - 运维
image: null
---

## 安装 Git

```bash
$ sudo apt-get install git
```

## Git 初始化配置

1.配置使用 Git 仓库的人员姓名

```bash
$ git config --global user.name "Your Name"
```

2.配置使用 Git 仓库的人员 Email

```bash
$ git config --global user.email "your@mail.com"
```

## 安装 SSH 并创建公钥

```bash
$ sudo apt-get install openssh-server
$ ssh-keygen -t rsa
```

连续按三下回车，公钥就创建了，公钥位于 ~/.ssh/ 目录下

```bash
$ cat ~/.ssh/id_rsa.pub
```

复制公钥内容，打开自己的 GitHub，设置 > SSH Keys 里面新建一个 SSH Key，将复制的内容粘贴保存就可以了

## 从 GitHub 上克隆项目

```bash
$ git clone git@github.com:yourname/project.git
```

然后就可以对项目目录下的文件进行编辑了

## 示例修改：

进入代码目录 project

```bash
$ cd project
```

建立测试文件 test.txt 并写入内容

```bash
$ echo 'test' > test.txt
```

将修改提交到 Git 缓冲区

```bash
$ git add test.txt
```

将缓冲区的修改提交

```bash
$ git commit -m "first commit"
```

提交到 GitHub

```bash
$ git push origin master
```

一次简单的 Git 克隆到提交就完成了。

## 远程仓库相关命令

> 　　检出仓库：$ git clone git://github.com/jquery/jquery.git
>
> 查看远程仓库：$ git remote -v
>
> 添加远程仓库：$ git remote add [name] [url]
>
> 删除远程仓库：$ git remote rm [name]
>
> 修改远程仓库：$ git remote set-url --push [name] [newUrl]
>
> 拉取远程仓库：$ git pull [remoteName] [localBranchName]
>
> 推送远程仓库：$ git push [remoteName] [localBranchName]

## 分支操作相关命令

> 查看本地分支：$ git branch
>
> 查看远程分支：$ git branch -r
>
> 创建本地分支：$ git branch [name]
>
> 　　切换分支：$ git checkout [name]
>
> 创并切换分支：$ git checkout -b [name]
>
> 　　删除分支：$ git branch -d [name]
>
> 　　合并分支：$ git merge [name]
>
> 创建远程分支：$ git push origin [name]
>
> 删除远程分支：$ git push origin :[name]
