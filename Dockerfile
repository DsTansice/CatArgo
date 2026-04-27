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

# 关键：设置 FILE_PATH 环境变量，让应用写到 /tmp 而不是 .tmp
ENV FILE_PATH=/tmp/app-tmp

CMD ["node", "index.js"]
