---
title: DNS域传送漏洞的简单使用
date: 2015-05-05
tags: [DNS, 安全, 漏洞]
---


#### **什么是DNS服务器**

Internet上的每台主机(Host)都有一个唯一的IP地址。IP协议就是使用这个地址在主机之间传递信息。
然而IP并不易于记忆，这就需要用户容易记忆的东西与IP进行一个转换，而DNS(Domain Name System，域名管理系统)服务器就是这个翻译的角色，将域名翻译为IP。

#### **域传送漏洞产生的原因**

DNS服务器分为：主服务器、备份服务器和缓存服务器。在主备服务器之间同步数据库，需要使用`DNS域传送`。
域传送是指后备服务器从主服务器拷贝数据，并用得到的数据更新自身数据库。
然而很多DNS服务器配置不当，就会导致任何匿名用户都可以获取DNS服务器某一域的所有记录

<!-- more -->

#### **简单使用**

* 将下面的 exampe.com 改为对应的域名，取得DNS服务器地址

```bash
$ dig example.com
```

![1](/uploads/dns-zone-transfer-bug/dns-1.png)

* 假如`example.com`的DNS服务器为`dns.example.com`

```bash
$ dig axfr @dns.example.com example.com
```

![2](/uploads/dns-zone-transfer-bug/dns-2.png)
