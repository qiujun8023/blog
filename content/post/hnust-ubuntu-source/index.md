---
title: 湖南科技大学 Ubuntu 内网源
date: '2015-01-22T00:00:00.000Z'
description: 针对教育网访问外部软件源缓慢的问题，作者在内网环境下搭建了专用的 Ubuntu 镜像源。本文提供了该源的访问地址，并详细列出了备份原源列表、修改 sources.list 以及更新软件列表的简单操作步骤。
tags:
  - Ubuntu
  - 镜像源
  - HNUST
categories:
  - 运维
image: null
---

## 缘由

最近不知为什么教育网访问国内的 Ubuntu 源非常的慢，迫于无奈，只有自己搭建一个 Ubuntu 内网源了。

注意：目前只是把把电子科技大学的 `Ubuntu 14.04` 源同步了下来

源的地址为：`http://mirror.qiujun.me/ubuntu/`

## 以下简单介绍如何修改源 

* 首先备份 Ubuntu 自带源列表

```bash
$ sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
```

* 使用 `vim` 打开源文件

```bash
$ sudo vim /etc/apt/sources.list
```

* 将以下内容加到 `sources.list` 最前面

```bash
#湖南科技大学内网源
deb http://mirror.qiujun.me/ubuntu/ trusty main restricted
deb-src http://mirror.qiujun.me/ubuntu/ trusty main restricted
deb http://mirror.qiujun.me/ubuntu/ trusty-updates main restricted
deb-src http://mirror.qiujun.me/ubuntu/ trusty-updates main restricted
deb http://mirror.qiujun.me/ubuntu/ trusty universe
deb-src http://mirror.qiujun.me/ubuntu/ trusty universe
deb http://mirror.qiujun.me/ubuntu/ trusty-updates universe
deb-src http://mirror.qiujun.me/ubuntu/ trusty-updates universe
deb http://mirror.qiujun.me/ubuntu/ trusty-security main restricted
deb-src http://mirror.qiujun.me/ubuntu/ trusty-security main restricted
deb http://mirror.qiujun.me/ubuntu/ trusty-security universe
deb-src http://mirror.qiujun.me/ubuntu/ trusty-security universe
```

* 更新软件列表

```bash
$ sudo apt-get update
```
