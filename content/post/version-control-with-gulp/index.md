---
title: 使用 Gulp 进行前端版本控制
date: '2016-05-06T00:00:00.000Z'
description: 探讨如何利用自动化构建工具 Gulp 解决浏览器缓存带来的静态资源更新不及时问题。文章对比了版本号与 Hash 文件名两种解决思路，并详细演示了如何通过 gulp-rev 与 gulp-rev-collector 插件实现 JS 文件的 Hash 改名及 HTML 引用自动替换的完整工作流。
tags:
  - Gulp
  - 前端工程化
  - 版本控制
categories:
  - 开发
image: null
---

## 前言

为了加快用户的访问速度，减少后端服务器的压力，基本都会用到浏览器缓存
然而缓存的使用，也带来一定的副作用，比如刷新不及时，导致页面错乱等

## 常见的解决办法

### 网址后面带上版本号，如：

```html
<script src="script.min.js?v=1.0.1"></script>
```

但是这种办法有几个缺点：
* 极少数浏览器可能不会缓存带有查询字符串的请求
* 如果使用 CDN 的话，极可能导致部分 CDN 缓存错误
* 发布是需要一个过程的，虽然过程及其短暂，但是如果访问量足够大，依然会导致页面的错乱
> 假如先发布的是 HTML 后发布的是 JS，用户请求到了新版本的 HTML 和旧版本的 JS，导致在以后的显示一直页面错乱
> 假如先发布 JS 后发布 HTML，用户请求到了旧版 HTML 和新版的 JS，会导致用户在本次的显示页面错乱

### 文件名带上 Hash

```html
<script src="script-abcdefg.min.js"></script>
```

* 其中的 abcdefg 则是根据文件 script.min.js 计算出来的 Hash 值
* 这种办法就很好的解决了以上的问题，同时如此处理还可以开启永久缓存
* 但是这种就必须要使用一定的自动化构建工具来实现，比如 `gulp`

## 什么是 Gulp

> Gulp.js 是一个自动化构建工具，开发者可以使用它在项目开发过程中自动执行常见任务。Gulp.js 是基于 Node.js 构建的，利用 Node.js 流的威力，你可以快速构建项目并减少频繁的 IO 操作。Gulp.js 源文件和你用来定义任务的 Gulp 文件都是通过 JavaScript（或者 CoffeeScript）源码来实现的。-- Gulp 中文网

Gulp 本身只提供最基础的流处理功能，但是你可以用第三库来做很多事情，常见的文件合并、压缩什么的更不是在话下


## 安装 Gulp

**前提：已经安装好 Node 与 NPM**

```bash
$ npm install --global gulp
```

## 安装并使用版本控制

安装项目目录下的 Gulp
```bash
$ npm install --save gulp
```

安装版本控制
```bash
$ npm install --save gulp-rev gulp-rev-collector
```

安装模块管理插件（此插件会自动分析 package.json 文件，并自动引入第三方库）
```bash
$ npm install --save gulp-load-plugins
```

编写自动化构建文件
* 这里定义了两个任务
* js 任务主要对 js 进行 Hash 改名并输出到 dist 目录下（当然正常情况下还会有什么合并、压缩之类的）
* rev 任务主要修改 index.html 中引入 js 的文件名
```bash
$ vim gulpfile.js # 填入下方内容
```
```javascript
var gulp = require('gulp')
var $    = require('gulp-load-plugins')()

gulp.task('js', function() {
    return gulp.src('src/js/script.js')
        .pipe($.rev()) //Hash改名
        .pipe(gulp.dest('dist/js')) //输出改名后的文件到指定目录
        .pipe($.rev.manifest())
        .pipe(gulp.dest('dist/rev/js')); //输出改名前后的对应关系
});

gulp.task('rev', ['js'], function() {
    var src = [
        'dist/rev/js/*.json', //上述输出的改名前后的对应关系
        'src/index.html'
    ]
    return gulp.src(src)
        .pipe($.revCollector()) //根据对应关系进行替换
        .pipe(gulp.dest('dist')); //输出替换后的问题
});
```

此时的目录结构
```bash
.
├── gulpfile.js
├── package.json
├── node_modules
│   └── ...
└── src
    ├── index.html
    └── js
        └── script.js
```

执行上述定义的任务 js
```bash
$ gulp js
```

执行后，如无报错，目录结构会如下所示
```bash
.
├── dist
│   ├── js
│   │   └── script-d41d8cd98f.js
│   └── rev
│       └── js
│           └── rev-manifest.json
├── gulpfile.js
├── package.json
├── node_modules
│   └── ...
└── src
    ├── index.html
    └── js
        └── script.js
```

其中 dist/rev/js/rev-manifest.json 文件会如下所示
```json
{
  "script.js": "script-d41d8cd98f.js"
}
```

然后执行上述定义的任务 rev
```bash
$ gulp rev
```

执行后目录结构会如下所示
```bash
.
├── dist
│   ├── index.html
│   ├── js
│   │   └── script-d41d8cd98f.js
│   └── rev
│       └── js
│           └── rev-manifest.json
├── gulpfile.js
├── package.json
├── node_modules
│   └── ...
└── src
    ├── index.html
    └── js
        └── script.js
```

同时 src/index.html 和 dist/index.html 的差异如下
```diff
-    <link rel="stylesheet" href="js/script.js">
+    <link rel="stylesheet" href="js/script-d41d8cd98f.js">
```

然后将 dist 对外发布就可以了
