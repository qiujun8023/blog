---
title: DNS域传送漏洞的简单使用
date: '2015-01-20T00:00:00.000Z'
description: 域传送是指 DNS 备份服务器从主服务器更新数据库的过程。本文介绍由于 DNS 服务器配置不当可能引发的域传送漏洞，演示如何利用 dig 工具获取目标域名的所有解析记录，并以此提醒管理员注意防护敏感信息泄露。
tags:
  - DNS
  - 安全漏洞
categories:
  - 安全
image: null
---

## 漏洞原理

域传送（Zone Transfer）是指备份服务器从主服务器拷贝数据，并以此更新自身数据库的过程。然而，如果 DNS 服务器配置不当，将允许任何匿名用户发起域传送请求，从而导致该域下的所有解析记录（包括内网 IP、子域名等敏感信息）泄露。

## 漏洞利用示例

1.  首先，获取目标域名的 DNS 服务器地址。将 `example.com` 替换为实际的目标域名：

```bash
$ dig example.com ns
```

2.  假设获取到其中一个 NS 服务器为 `ns1.example.com`。接下来，尝试向该服务器发起域传送请求（AXFR）：

```bash
$ dig @ns1.example.com example.com axfr
```

3.  如果存在漏洞，你将看到该域下的所有 DNS 记录被列出，如下图所示：

![漏洞利用示例](images/result.png)

## 防范建议

为了防范此漏洞，DNS 管理员应严格限制允许进行域传送的 IP 地址，通常只允许特定的从服务器（Secondary DNS）进行同步。在 Linux 的 Bind 服务中，可以通过配置文件中的 `allow-transfer` 选项进行限制。
