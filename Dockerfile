# 构建阶段：官方 Hugo 镜像自带 Dart Sass 和拉取 Hugo Modules 所需的 Go、git；
# 只在构建机原生架构上生成一次静态页面，供各架构镜像共用
FROM --platform=$BUILDPLATFORM ghcr.io/gohugoio/hugo:latest AS builder

WORKDIR /src
# 镜像以 hugo 用户运行，构建时要写 public/ 和 assets/jsconfig.json
COPY --chown=hugo:hugo . .
RUN hugo --minify

# 运行阶段
FROM nginx:alpine-slim
COPY --from=builder /src/public /usr/share/nginx/html
EXPOSE 80
