---
title: HTTP协议中PUT和POST使用区别
date: 2016-04-10
tags: [HTTP]
---

#### **常见的HTTP操作及RESTful api**
HTTP/1.1协议中共定义了8中请求方法：GET、HEAD、POST、PUT、DELETE、CONNECT、OPTIONS、TRACE，其中用的相对较多的有下面四种：

```http
GET      获取资源
PUT      更新或创建资源
POST     创建资源
DELETE   删除资源
```

RESTful api则充分利用了HTTP协议，每个资源对应一个具体的URI，然后利用不同的HTTP操作对应增删改查，如：

```http
POST       /uri       创建
DELETE     /uri/xxx   删除
PUT        /uri/xxx   更新或创建
GET        /uri/xxx   查看
```

可以看到，`GET`和`DELETE`对应的操作非常明确，但是`POST`与`PUT`都可以进行资源的创建，那么什么时候用`POST`什么时候用`PUT`呢

<!-- more -->

这就需要了解HTTP协议中的另一个重要性质：幂等

#### **什么是幂等**

要理解PUT和POST的区别，还要知道HTTP协议中的一个重要性质，幂等（Idempotence）：

> Methods can also have the property of "idempotence" in that (aside from error or expiration issues) the side-effects of N > 0 identical requests is the same as for a single request.

什么个意思呢？HTTP协议中的幂等指的是一个资源无论请求多少次，对他产生的副作用是一样的

* GET操作是安全的，也就是不管操作多少次，资源的状态都不会改变，所以GET也是幂等的
* PUT和DELETE是幂等的，比如我用PUT或者DELETE修改一个资源，不管操作多少次，每次操作后的结果并没有什么不同
* POST操作既不是安全的，也不是幂等的，如果常见的POST重复加载的问题，我们进行了多少次POST的操作，最后就创建了多少个资源，这也是为什么Chrom等浏览器，在刷新POST请求时会有弹窗提示

#### **什么时候用PUT什么时候用POST**

既然已经知道了PUST是幂等的，而POST是既不幂等也不安全的，那什么时候用PUT什么时候用POST呢

##### **什么时候用POST**

在不知道资源标志符时用POST创建，也就是POST是作用在一个资源集合上。也就是当只知道被创建的资源的父节点是谁时用POST

```http
HTTP POST /uri
```

##### **什么时候用PUT**

在允许客户端指定资源标识符时用PUT创建，也就是PUT是作用在一个特定资源上

```http
HTTP PUT /uri/xxx
```

也就是说资源的URI由客户端确定的话就用PUT，由服务端确定的话就用POST，比如很多资源使用的是数据库自增主键标志，那么这个时候资源的创建就必须用POST
