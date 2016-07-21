---
title: 使用 BAE + SSH隧道 进行内网穿透
date: 2015-03-13
tags: [BAE, SSH, Node.js]
---

#### **起因**

* 由于电脑处于学校内网，没有公网IP，一般情况下，公网是无法访问自己的电脑的
* 出于一些原因自己的电脑或者内网中设备需要对外提供服务
* 尝试比如花生壳、NAT123之类的，效果不尽人意

#### **原理**

* 原理主要是利用SSH隧道 + Node.js反向代理
* 用户请求 -> BAE Node.js -> SSH隧道 -> 内网服务器

<!-- more -->

#### **预备工作**

* 一般情况下百度云不会提供Port服务，需要自己主动申请Port，申请通过大概需要一天

* 申请通过后，先创建`Node.js`项目和`Port`服务

* 创建好后将`Port`的端口改为`22`，如图所示

![端口](/uploads/bae-ssh/port.png)

* 复制代码库地址，克隆下来

![代码库](/uploads/bae-ssh/git_svn.png)

#### **添加公钥**

* 创建公钥及获取公钥内容

```bash
$ ssh-keygen    #创建公钥
$ cat ~/.ssh/id_rsa.pub #得到公钥内容
```

* 打开刚从BAE克隆下来的文件夹，将得到的公钥内容复制到`app.conf`文件中
  ![添加公钥](/uploads/bae-ssh/id_rsa.png)

* 这时可以通过`ssh bae@[ip] –p [port]`测试，看能否正常连接

#### **设置`Node.js`反向代理**

* 在`package.json`文件中dependencies下加上以下内容，如图

```json
"http-proxy" : "1.9.0"
```

![添加http-proxy模块](/uploads/bae-ssh/package.png)

* 将以下内容替换`server.js`原有的内容

```javascript
/*
http-proxy
*/
var http = require('http');
var httpProxy = require('http-proxy');
var proxy = httpProxy.createProxyServer({});
http.createServer(function(req, res) {
    proxy.web(req, res, {
        target :'http://127.0.0.1:8090' //这里的端口只要和后面的SSH隧道映射端口一致就行
    })
}).listen(18080);
```

#### **建立SSH隧道**

* 下面的`8090`与上面`server.js`文件里面的`8090`对应，请把`125.221.232.253:80`改为想映射的网址，请把`111.206.45.12`改为百度云Port服务对应的IP，把`30349`改为百度云Port服务对应的端口

```bash
ssh -C -N -f -g -R 8090:125.221.232.253:80 bae@111.206.45.12 -p 30349
```

#### **效果展示**

访问百度云提供的域名，已成功映射

![效果展示](/uploads/bae-ssh/result.png)
