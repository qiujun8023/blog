---
title: Ubuntu 下安装 Apache+PHP+MySQL
date: '2015-05-04T00:00:00.000Z'
description: 详细讲解在 Debian 与 Ubuntu 操作系统中搭建 LAMP（Apache, PHP, MySQL）环境的操作流程。文章涵盖了各组件的安装、服务端重启、PHP 环境验证方法，并针对 Apache 域名警告、网站根目录修改及 PHPMyAdmin 扩展缺失等常见问题提供了解决方案。
tags:
  - Ubuntu
  - LAMP
categories:
  - 运维
image: null
---

以下是在 Debian 及 Ubuntu 安装 Apache、PHP、MySQL 的步骤及相关问题的解决办法

## 安装

* 安装前更新源

```bash
$ sudo apt-get update
```

* 安装 Apache2 并重启

```bash
$ sudo apt-get install apache2
$ sudo service apache2 restart
```

这时访问 `http://localhost`（如果是服务器改为服务器地址），如果能够正常访问，那 Apache 基本上是安装成功了。

* 安装 PHP

```bash
$ sudo apt-get install libapache2-mod-php5 php5 php5-gd php5-mysql
```

* 安装完成后，重启 Apache2

```bash
$ sudo service apache2 restart
```

* 新建测试文件，测试 php 是否安装成功

```bash
$ sudo vim /var/www/test.php
```

* 填写以下内容

```php
<?php
phpinfo();
```

保存后访问 `http://localhost/test.php`，显示内容如下就表示 PHP 模块安装成功了

  ![phpinfo](images/phpinfo.png)

* 安装 MySQL，安装过程中会要求设置 MySQL 的密码，设置即可

```bash
$ sudo apt-get install mysql-server mysql-client
```

* 重启 MySQL

```bash
$ sudo /etc/init.d/mysql restart
```

如果需要安装 PHPMyAdmin 则按照下面命令安装，安装过程中会要求选择服务器类型，选择 apache，然后需要输入上面设置的 MySQL 密码

```bash
$ sudo apt-get install phpmyadmin
```

* 建立软链接

```bash
$ sudo ln -s /usr/share/phpmyadmin /var/www/
```

## 常见问题解决

* 重启 Apache2 时报如下提示：
> AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.31. Set the 'ServerName' directive globally to suppress this message
解决办法如下：

```bash
$ sudo vim /etc/apache2/apache2.conf
```

在其最后一行加上

> ServerName localhost

然后重启 Apache2 即可

```bash
$ sudo service apache2 restart
```

---

* 网站根目录为 /var/www/html 而不是/var/www，解决方法如下：

```bash
$ sudo vim /etc/apache2/sites-available/000-default.conf
```

然后将其中的/var/www/html 改为 /var/www，然后重启 Apache2 即可

```bash
$ sudo service apache2 restart
```

---

* PHPMyAdmin 报错 `缺少 mcrypt 扩展。请检查 PHP 配置。` 解决办法如下：

```bash
$ sudo apt-get install php5-mcrypt libmcrypt4 libmcrypt-dev
$ sudo ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/apache2/conf.d/20-mcrypt.ini
$ sudo service apache2 restart
```
