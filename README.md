# Jun's Blog

这是一个基于 [Hugo](https://gohugo.io/) 构建的现代化个人博客，使用了极简且功能强大的 [Hugo Theme Stack](https://github.com/CaiJimmy/hugo-theme-stack) 主题。

## 🚀 快速开始

### 1. 环境准备
本项目使用 Hugo Modules 管理主题，建议安装 **Hugo Extended** 版本（v0.140.0 或更高）。

```bash
# macOS (使用 Homebrew)
brew install hugo

# 验证版本
hugo version
```

### 2. 本地开发
在项目根目录下运行以下命令启动预览服务器：

```bash
hugo server -D
```
启动后访问 `http://localhost:1313` 即可实时预览。

## 📝 日常使用

### 创建新文章
```bash
hugo new post/文章名称/index.md
```
文章将创建在 `content/post/文章名称/index.md`。建议采用 **Page Bundle** 结构（即每个文章一个文件夹），方便管理该文章相关的图片。

### 图片管理
*   **文章内图片**：建议放在文章所在的文件夹下，直接在 Markdown 中引用。
*   **公共资源**：存放在 `static/uploads/` 目录下。

## 🏗️ 构建与部署

运行以下命令生成最终的静态网页文件：

```bash
hugo --minify
```
生成的产物位于 `public/` 目录，你可以将其部署到 GitHub Pages、Vercel 或 Netlify。

## 📂 目录结构说明

- `archetypes/`: 文章初始模板。
- `assets/`: 需要经过 Hugo 处理的资源（SCSS, JS）。
- `content/`: 博客内容（Markdown 文件）。
- `data/`: 全局自定义数据。
- `hugo.yaml`: 核心配置文件（标题、菜单、侧边栏挂件等）。
- `layouts/`: 用于覆盖主题默认布局的自定义模板。
- `static/`: 原样输出的静态文件（如 Favicon、头像）。

## 🛠️ 技术细节

- **主题模式**: Hugo Modules (无需下载主题源码到项目内)。
- **样式**: 基于主题内置的响应式设计。
- **国际化**: 已配置为 `zh-cn`。
