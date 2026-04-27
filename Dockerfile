FROM node:alpine3.20

# 1. 显式创建 UID 10001 的用户（Checkov 要求 + 运行时需要）
RUN addgroup -g 10001 -S appgroup && \
    adduser -u 10001 -S appuser -G appgroup

WORKDIR /app

# 2. 复制文件，并设置属主为 10001（关键！）
COPY --chown=10001:10001 . .

# 3. 安装依赖（此时还是 root，可以装系统包）
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    npm install

EXPOSE 3000/tcp

# 4. USER 必须在 CMD 之前（Checkov 要求）
USER 10001

# 5. 启动命令
CMD ["node", "index.js"]
