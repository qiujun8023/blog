---
title: 湖南科技大学 Ubuntu 内网源
date: 2015-01-22
tags: [HNUST, Ubuntu]
---

#### **缘由**

最近不知为什么教育网访问国内的Ubuntu源非常的慢，迫于无奈，只有自己搭建一个一个Ubuntu内网源了。

注意：目前只是把把电子科技大学的 `Ubuntu 14.04` 源同步了下来

源的地址为：`http://mirror.qious.cn/ubuntu/`

<!-- more -->

#### **以下简单介绍如何修改源 **

* 首先备份Ubuntu自带源列表

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
deb http://mirror.qious.cn/ubuntu/ trusty main restricted
deb-src http://mirror.qious.cn/ubuntu/ trusty main restricted
deb http://mirror.qious.cn/ubuntu/ trusty-updates main restricted
deb-src http://mirror.qious.cn/ubuntu/ trusty-updates main restricted
deb http://mirror.qious.cn/ubuntu/ trusty universe
deb-src http://mirror.qious.cn/ubuntu/ trusty universe
deb http://mirror.qious.cn/ubuntu/ trusty-updates universe
deb-src http://mirror.qious.cn/ubuntu/ trusty-updates universe
deb http://mirror.qious.cn/ubuntu/ trusty-security main restricted
deb-src http://mirror.qious.cn/ubuntu/ trusty-security main restricted
deb http://mirror.qious.cn/ubuntu/ trusty-security universe
deb-src http://mirror.qious.cn/ubuntu/ trusty-security universe
```

* 更新软件列表

```bash
$ sudo apt-get update
```