---
title: 解决 perl warning Setting locale failed 错误
date: '2015-01-24T00:00:00.000Z'
description: null
tags:
  - Ubuntu
categories: []
image: null
---

#### **错误原因**

* 在Ubuntu Server上执行apt-get install命令时，总是报此错误
* 个人感觉错误原因主要还是应为SSH登陆时会传输客户端的语言，而服务端缺少相应的语言支持
* 所以安装对应的语言支持就好了，下面已简体中文为例

<!-- more -->

#### **错误提示**

```bash
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
 LANGUAGE = "en_US:en",
 LC_ALL = (unset),
 LC_PAPER = "en_US",
 LC_ADDRESS = "en_US",
 LC_MONETARY = "en_US",
 LC_NUMERIC = "en_US",
 LC_TELEPHONE = "en_US",
 LC_IDENTIFICATION = "en_US",
 LC_MEASUREMENT = "en_US",
 LC_TIME = "en_US",
 LC_NAME = "en_US",
 LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
```

#### **解决办法**

```bash```
$ sudo apt-get install language-pack-en-base language-pack-zh-hant-base language-pack-zh-hans-base language-pack-zh-hans language-pack-zh-hant;
```
