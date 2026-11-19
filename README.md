# Jun's Blog

个人技术博客 [www.qiujun.me](https://www.qiujun.me)，用 [Hugo](https://gohugo.io/) 生成静态页面，主题是 [Stack](https://github.com/CaiJimmy/hugo-theme-stack) v4，通过 Hugo Modules 引入。

## 本地开发

需要 Hugo 和 Dart Sass：主题样式是 SCSS，Hugo 自 v0.170 起只用 Dart Sass 编译；拉取主题模块需要 Go。

```bash
brew install hugo sass/sass/sass go
hugo server -D        # 预览 http://localhost:1313
```

新文章用 Page Bundle，一篇一个目录，配图放在同目录下直接引用：

```bash
hugo new post/<slug>/index.md
```

## 依赖升级

- 主题：`hugo mod get -u github.com/CaiJimmy/hugo-theme-stack/v4 && hugo mod tidy`。跨大版本时模块路径会变（`/v4` → `/v5`），要同时改 `hugo.yaml` 的 `module.imports`，并对照主题的升级说明检查 `layouts/` 下的覆盖模板。
- Hugo 和 nginx 用浮动 tag，重新构建即升级，不需要改文件。

## 构建与部署

推送到 `master` 后 GitHub Actions 构建多架构镜像，推到私有仓库的 `personal/blog:latest` 和 `personal/blog:<短 SHA>`。构建阶段用官方 `ghcr.io/gohugoio/hugo` 镜像，运行阶段用 `nginx:alpine-slim`。CI 只负责推镜像，服务器上要自己拉取并重建容器。

## 目录

- `hugo.yaml`：站点配置，包括菜单、侧栏挂件和页脚备案信息。
- `content/`：文章在 `post/`，另有 `about/`、`archives/`、`search/` 三个独立页面。`search/` 必须保持 `type: page`，否则主题的搜索模板和 JSON 索引不会生效。
- `layouts/_partials/footer/footer.html`：覆盖主题页脚，改成备案、版权、驱动信息三栏，样式在 `assets/scss/custom.scss`。
- `assets/`：头像图片和自定义样式。

## 许可协议

- **代码**（配置、模板、样式、脚本等）：[MIT](LICENSE)
- **内容**（`content/` 下的文章及其配图）：[CC BY-NC-SA 4.0](LICENSE-CONTENT)，转载请署名、注明出处，不得用于商业用途，改编后须以相同协议发布
