FROM node:alpine3.20

RUN addgroup -g 10001 -S appgroup && \
    adduser -u 10001 -S appuser -G appgroup

WORKDIR /home/appuser

COPY --chown=10001:10001 . /home/appuser/

RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    npm install

EXPOSE 3000/tcp

USER 10001

# 关键：启动时把 .tmp 建到 /tmp 下，或者改应用配置
CMD ["sh", "-c", "ln -sf /tmp /home/appuser/.tmp 2>/dev/null; node index.js"]
