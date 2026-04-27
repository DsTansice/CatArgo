FROM node:alpine3.20

# 先创建用户
RUN addgroup -g 10001 -S appgroup && \
    adduser -u 10001 -S appuser -G appgroup

# 用 /home/appuser 作为工作目录（可写）
WORKDIR /home/appuser

# 复制文件并设置属主
COPY --chown=10001:10001 . /home/appuser/

# 安装依赖
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    npm install

EXPOSE 3000/tcp

# 切换用户（Checkov 要求）
USER 10001

# 启动
CMD ["node", "index.js"]
