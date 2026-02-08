# 第一阶段：构建静态页面
FROM floryn90/hugo:ext-alpine AS builder

WORKDIR /src
COPY . .

# 如果使用了 Hugo Modules，需要网络下载依赖
RUN hugo --minify

# 第二阶段：Nginx 提供服务
FROM nginx:alpine

# 复制构建产物到 Nginx 目录
COPY --from=builder /src/public /usr/share/nginx/html

# 复制自定义 Nginx 配置（如果需要，这里暂用默认）
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
