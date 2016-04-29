---
title: 在Nginx上配置HTTP/2+TLS
date: 2016-04-17
tags: [Ubuntu, Nginx, HTTP]
---

#### **什么是HTTP/2协议**

> HTTP 2.0即超文本传输协议 2.0，是下一代HTTP协议。是由互联网工程任务组（IETF）的Hypertext Transfer Protocol Bis (httpbis)工作小组进行开发。是自1999年http1.1发布后的首个更新。HTTP 2.0在2013年8月进行首次合作共事性测试。在开放互联网上HTTP 2.0将只用于https:// 网址，而 http:// 网址将继续使用HTTP/1，目的是在开放互联网上增加使用加密技术，以提供强有力的保护去遏制主动攻击。

#### **HTTP/2协议的主要特性**

* 采用二进制格式传输数据，而非文本格式
* 对消息头进行压缩传输，能够节省消息头占用的网络的流量
* 多路复用，就是多个请求都是通过一个 TCP 连接并发完成
* 服务器推送，服务端能够主动把资源推送给客户端
* ...

<!--more-->

#### **启用HTTP/2的Nginx服务器要求**

* OpenSSL版本需要1.0.2及以上
* Nginx版本需要1.9.0及以上

#### **检查服务器OpenSSL版本**

通过下面的命令可以查看OpenSSL版本号

```bash
$ openssl version -a
```

如果版本低于1.0.2则执行下面的升级命令

```bash
$ wget http://openssl.org/source/openssl-1.0.2g.tar.gz
$ tar zxvf openssl-1.0.2g.tar.gz
$ cd openssl-1.0.2g
$ ./configure && make && sudo make install
```

上述命令使用默认配置源码安装OpenSSL，可以根据情况自定义，安装后再覆盖原有OpenSSL

```bash
$ sudo mv /usr/bin/openssl /usr/bin/openssl.bak
$ sudo mv /usr/include/openssl /usr/include/openssl.bak
$ sudo ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl
$ sudo ln -s /usr/local/ssl/include/openssl/ /usr/include/openssl
$ sudo echo "/usr/local/ssl/lib" >>/etc/ld.so.conf
```

#### **准备SSL证书**

如果已经有SSL证书的用户此步可以略过

* 申请[免费的沃通证书](https://buy.wosign.com/FreeSSL.html)，填写一些简单资料，证书很快就可以下发
* 分别解压下载的zip文件后zip文件里面的for Nginx.zip，得到一个key文件和一个crt文件
* 移动key文件和crt文件到ssl目录下(可选)

```bash
$ mv server.crt /usr/local/ssl/certs/
$ mv server.key /usr/local/ssl/private/
```

#### **安装或升级Nginx**

安装升级Nginx可使用[源码方式](#源码安装、升级Nginx)或者[apt-get方式](#apt-get方式安装、升级Nginx)

##### **源码安装、升级Nginx**

* 下载Nginx

```bash
$ wget http://nginx.org/download/nginx-1.9.14.tar.gz
$ tar zxvf nginx-1.9.14.tar.gz
$ cd nginx-1.9.14
```

* 编译

```bash
$ ./configure --with-http_v2_module --with-http_ssl_module
```

* 在`./configure`过程中如果报需要填写ssl目录，则可能需要安装 `libssl-dev`，使用apt-get安装即可

```bash
$ sudo apt-get install libssl-dev
```

* 安装或升级

```bash
$ make && sudo make install #安装
$ make && sudo make upgrade #升级
```

##### **apt-get方式安装、升级Nginx**

* 由于需要1.9及以上版本的Nginx，所以这里需要安装mainline版本

```bash
$ sudo vim /etc/apt/sources.list
```

* 用`vim`打开后添加以下两行，也可以用`echo`命令添加

```bash
deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx
deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx
```

* 添加apt-key

```bash
$ wget http://nginx.org/keys/nginx_signing.key
$ sudo apt-key add nginx_signing.key
```

* 更新源并安装、升级

```bash
$ sudo apt-get update
$ sudo apt-get install nginx
```

#### **配置Nginx**

配置文件内容类似与下

```nginx
server {
    listen 443 http2;
    server_name  qious.cn www.qious.cn;

    ssl on;
    ssl_certificate     /usr/local/ssl/certs/server.crt;
    ssl_certificate_key /usr/local/ssl/private/server.key;

    ...
}
```

重新加载配置文件

```bash
$ sudo service nginx reload
```

如一切顺利就可以正常访问了