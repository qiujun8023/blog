---
title: 利用 GitHub&Jekyll 搭建一个免费博客
date: '2015-01-09T00:00:00.000Z'
description: 详细指导如何利用 GitHub Pages 托管服务与 Jekyll 静态网站生成器构建个人博客。内容包括搭建本地 Ruby 与 Jekyll 环境、创建 GitHub 项目、管理分支、配置站点结构及最终推送到 GitHub 的全过程。
tags:
  - Jekyll
  - GitHub Pages
  - 静态网站
categories:
  - 运维
image: null
---

## 为什么用 GitHub Pages

* Git 是一个开源的分布式版本控制系统，用以有效、高速的处理从很小到非常大的项目版本管理。
* GitHub 是一个提供免费托管 Git 库的站点
* GitHub Pages 的特点：免费托管、绑定域名、自带主题、支持自制页面和 Jekyll。
* Jekyll 是一个静态站点生成器，它会根据网页源码生成静态文件。它提供了模板、变量、插件等功能，可以用来编写整个网站。

## 用 GitHub Pages 的好处

* 托管于 GitHub,不用担心文章的丢失,即使文章误删也可以快速恢复
* 免费&无限流量
* 可以绑定自己的域名(只能绑定一个)

## 搭建本地 Jekyll 环境

* 安装 Ruby（因为 Jekyll 是 Ruby 写的）

```bash
$ sudo apt-get install ruby ruby-dev
```

* 修改 ruby 软件源

```bash
$ gem sources --remove http://rubygems.org/
$ gem sources -a https://ruby.taobao.org/
$ gem sources -u
```

* 安装 `Jekyll`

```bash
$ sudo gem install jekyll
```
可能需要等一会

* 安装 `NodeJs` 不然运行的话会报 `Could not find a JavaScript runtime.`

```bash
$ sudo apt-get install nodejs
```

到此本地 Jekyll 环境就搭建好了

## GitHub 创建一个项目

先确保本地已经搭建 Git 环境且有 Git 账号，然后 GitHub 创建一个项目 假定为 Blog

* 克隆项目到本地(将下面的 username 换成你的名字)

```bash
$ git clone https://github.com/username/Blog.git
```

* 切换到 Blog 目录

```bash
$ cd Blog
```

* 修改分支名称

```bash
$ git branch -m master gh-pages
$ git push origin gh-pages
```

在 GitHub 的 Blog 项目找到主分支切换，选择 gh-pages 分支

![分支切换](images/gh-pages.png)

* 删除 GitHub 的 master 分支

```bash
$ git push --delete origin master
```

## Jekyll 搭建示例

* 绑定域名（没有域名可以忽略）

```bash
$ vim CNAME
```

在里面填入你的域名，并将域名的 CNAME 记录指向到 `ursename.github.io`

* 创建 Jekyll 的配置

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

正常会在 4000 端口运行，用浏览器打开 `127.0.0.1:4000`,如果看到以下的内容，那么就搭建成功了

![浏览器打开效果](images/my_blog.png)

## Push 到 GitHub

* 提交并推送到 GitHub

```bash
$ git add .
$ git commit -m "hello world"
$ git push origin gh-pages
```

* 这时打开上面你 CNAME 指向的域名或者 GitHub 的域名（usename.github.io/Blog）

一个简单的博客就搭建完成了

注：push 到 GitHub 后不会立即生效，大概要等 30s 左右
