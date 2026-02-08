---
title: 利用GitHub&Jekyll搭建一个免费博客
date: '2015-01-09T00:00:00.000Z'
description: null
tags:
  - Jekyll
  - GitHub
categories: []
image: null
---

#### **为什么用GitHub Pages**

* Git是一个开源的分布式版本控制系统，用以有效、高速的处理从很小到非常大的项目版本管理。
* GitHub是一个提供免费托管Git库的站点
* GitHub Pages的特点：免费托管、绑定域名、自带主题、支持自制页面和Jekyll。
* Jekyll是一个静态站点生成器，它会根据网页源码生成静态文件。它提供了模板、变量、插件等功能，可以用来编写整个网站。

#### **用GitHub Pages的好处**

* 托管于GitHub,不用担心文章的丢失,即使文章误删也可以快速恢复
* 免费&无限流量
* 可以绑定自己的域名(只能绑定一个)

<!-- more -->

#### **搭建本地Jekyll环境**

* 安装Ruby（因为Jekyll是Ruby写的）

```bash
$ sudo apt-get install ruby ruby-dev
```

* 修改ruby软件源

```bash
$ gem sources --remove http://rubygems.org/
$ gem sources -a https://ruby.taobao.org/
$ gem sources -u
```

* 安装`Jekyll`

```bash
$ sudo gem install jekyll
```
可能需要等一会

* 安装`NodeJs` 不然运行的话会报 `Could not find a JavaScript runtime.`

```bash
$ sudo apt-get install nodejs
```

到此本地Jekyll环境就搭建好了

#### **GitHub创建一个项目**

先确保本地已经搭建Git环境且有Git账号，然后GitHub 创建一个项目 假定为Blog

* 克隆项目到本地(将下面的username换成你的名字)

```bash
$ git clone https://github.com/username/Blog.git
```

* 切换到Blog目录

```bash
$ cd Blog
```

* 修改分支名称

```bash
$ git branch -m master gh-pages
$ git push origin gh-pages
```

在GitHub的Blog项目找到主分支切换，选择gh-pages分支

![分支切换](images/gh-pages.png)

* 删除GitHub的master分支

```bash
$ git push --delete origin master
```

#### **Jekyll搭建示例**

* 绑定域名（没有域名可以忽略）

```bash
$ vim CNAME
```

在里面填入你的域名，并将域名的CNAME记录指向到`ursename.github.io`

* 创建Jekyll的配置

```bash
$ vim _config.yml
```

在里面填入以下内容

> title: My Blog
> baseurl: ""

* 创建模板文件夹

```bash
$ mkdir _layouts
```

* 创建一个模板文件

```bash
$ vim _layouts/default.html
```

在里面写入以下内容

```html
<!DOCTYPE html>
  <html>
    <head>
      <meta http-equiv="content-type" content="text/html; charset=utf-8" />
      <title>{{ page.title }}</title>
    </head>
  <body>
    {{ content }}
  </body>
</html>
```

* 创建文章目录

```bash
$ mkdir _posts
```

* 创建一篇文章

```bash
$ vim _posts/2015-01-01-hello_world.md
```

在里面填入以下内容

```markdown
{% raw %}
---
layout: default
title: hello world
---
<h2>{{ page.title }}</h2>
<p>你好，世界</p>
{% endraw %}
```

* 创建首页

```bash
$ vim index.md
```

在里面填入以下内容

```markdown
---
layout: default
title: 我的Blog
---
{% raw %}
<h2>{{ page.title }}</h2>
<p>最新文章</p>
<ul>
{% for post in site.posts %}
  <li>
    {{ post.date | date_to_string }}
    <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
  </li>
{% endfor %}
</ul>
{% endraw %}
```

* 这时的目录结构应该是这样的

```bash
.
├── _config.yml
├── index.md
├── _layouts
│   └── default.html
├── _posts
│   └── 2015-01-01-hello_world.md
└── README.md
```

* 本地环境运行

```bash
$ jekyll server
```

正常会在4000端口运行，用浏览器打开`127.0.0.1:4000`,如果看到以下的内容，那么就搭建成功了

![浏览器打开效果](images/my_blog.png)

#### **Push到GitHub**

* 提交并推送到GitHub

```bash
$ git add .
$ git commit -m "hello world"
$ git push origin gh-pages
```

* 这时打开上面你CNAME指向的域名或者GitHub的域名（usename.github.io/Blog）

一个简单的博客就搭建完成了

注：push到GitHub后不会立即生效，大概要等30s左右
