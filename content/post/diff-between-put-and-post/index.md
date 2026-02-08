---
title: HTTP协议中PUT和POST使用区别
date: '2016-04-10T00:00:00.000Z'
description: 深入分析 HTTP 协议中 PUT 与 POST 方法的语义差异。文章介绍了 RESTful API 中的常见操作，并重点阐述了“幂等性”这一核心概念，帮助开发者在资源创建与更新场景下做出正确的请求方法选择。
tags:
  - HTTP
  - RESTful
categories:
  - 开发
image: null
---

## 常见的 HTTP 操作及 RESTful API

HTTP/1.1 协议中共定义了 8 种请求方法：GET、HEAD、POST、PUT、DELETE、CONNECT、OPTIONS、TRACE，其中用的相对较多的有下面四种：

```http
GET      获取资源
PUT      更新或创建资源
POST     创建资源
DELETE   删除资源
```

RESTful API 则充分利用了 HTTP 协议，每个资源对应一个具体的 URI，然后利用不同的 HTTP 操作对应增删改查，如：

```http
POST       /uri       创建
DELETE     /uri/xxx   删除
PUT        /uri/xxx   更新或创建
GET        /uri/xxx   查看
```

可以看到，`GET` 和 `DELETE` 对应的操作非常明确，但是 `POST` 与 `PUT` 都可以进行资源的创建，那么什么时候用 `POST` 什么时候用 `PUT` 呢？

这就需要了解 HTTP 协议中的另一个重要性质：幂等性。

## 什么是幂等性

要理解 PUT 和 POST 的区别，首先要了解 HTTP 协议中的重要性质——幂等（Idempotence）：

> Methods can also have the property of "idempotence" in that (aside from error or expiration issues) the side-effects of N > 0 identical requests is the same as for a single request.

简单来说，HTTP 协议中的幂等指的是：对同一个资源进行多次请求，其副作用与单次请求产生的副作用是相同的。

*   **GET 操作**是安全的，无论操作多少次，资源的状态都不会改变，因此 GET 是幂等的。
*   **PUT 和 DELETE** 是幂等的。例如，使用 PUT 修改一个资源，无论执行多少次请求，最终资源的状态都是一致的。
*   **POST 操作**既不是安全的，也不是幂等的。常见的例子是表单重复提交，每执行一次 POST 就会创建一个新资源，这就是为什么 Chrome 等浏览器在刷新 POST 请求时会弹出警告。

## 什么时候用 PUT，什么时候用 POST？

既然知道了 PUT 是幂等的，而 POST 既不幂等也不安全，那该如何选择？

### 什么时候用 POST

在**不知道资源标识符（Resource Identifier）**时使用 POST 创建资源。此时 POST 作用于资源集合上，由服务端生成该资源的 URI。

```http
HTTP POST /uri
```

### 什么时候用 PUT

在**允许客户端指定资源标识符**时使用 PUT 创建或更新资源。此时 PUT 作用于特定资源（Specific Resource）。

```http
HTTP PUT /uri/xxx
```

总结：如果资源的 URI 由客户端确定，则使用 PUT；如果由服务端确定（如数据库自增主键），则必须使用 POST。
