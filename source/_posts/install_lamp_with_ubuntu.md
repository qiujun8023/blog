---
title: Ubuntu下安装Apache+PHP+MySQL
date: 2015-05-04
tags: [Ubuntu, Apache, PHP, MySQL]
---

以下是在 Debian 及 Ubuntu 安裝 Apache、PHP、MySQL的步驟及相关问题的解决办法

#### **安装**

* 安装前更新源

```bash
$ sudo apt-get update
```

<!-- more -->

* 安装Apache2并重启

```bash
$ sudo apt-get install apache2
$ sudo service apache2 restart
```

这时访问`http://localhost`（如果是服务器改为服务器地址），如果能够正常访问，那Apache基本上是安装成功了。

* 安装PHP

```bash
	  $ sudo apt-get install libapache2-mod-php5 php5 php5-gd php5-mysql
```

* 安装完成后，重启Apache2

```bash
	  $ sudo service apache2 restart
```

* 新建测试文件，测试php是否安装成功

```bash
	  $ sudo vim /var/www/test.php
```

* 填写以下内容

```php
<?php
phpinfo();
```

保存后访问 `http://localhost/test.php`，显示内容如下就表示PHP模块安装成功了

  ![phpinfo](/uploads/20150504/phpinfo.png)

* 安装MySQL，安装过程中会要求设置MySQL的密码，设置即可

```bash
$ sudo apt-get install mysql-server mysql-client
```

* 重启MySQL

```bash
$ sudo /etc/init.d/mysql restart
```

如果需要安装PHPMyAdmin则按照下面命令安装，安装过程中会要求选择服务器类型，选择apache，然后需要输入上面设置的MySQL密码

```bash
$ sudo apt-get install phpmyadmin
```

* 建立软链接

```bash
$ sudo ln -s /usr/share/phpmyadmin /var/www/
```

#### **常见问题解决**

* 重启Apache2时报如下提示：
> AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.31. Set the 'ServerName' directive globally to suppress this message
解决办法如下：

```bash
$ sudo vim /etc/apache2/apache2.conf
```

在其最后一行加上

> ServerName localhost

然后重启Apache2即可

```bash
$ sudo service apache2 restart
```

---

* 网站根目录为 /var/www/html 而不是/var/www，解决方法如下：

```bash
$ sudo vim /etc/apache2/sites-available/000-default.conf
```

然后将其中的/var/www/html 改为 /var/www ，然后重启Apache2即可

```bash
$ sudo service apache2 restart
```

---

* PHPMyAdmin报错 `缺少 mcrypt 扩展。请检查 PHP 配置。` 解决办法如下：

```bash
$ sudo apt-get install php5-mcrypt libmcrypt4 libmcrypt-dev
$ sudo ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/apache2/conf.d/20-mcrypt.ini
$ sudo service apache2 restart
```