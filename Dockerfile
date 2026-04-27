FROM node:alpine3.20

WORKDIR /home/appuser

COPY --chown=10001:10001 . /home/appuser/

RUN addgroup -g 10001 -S appgroup && \
    adduser -u 10001 -S appuser -G appgroup && \
    chown -R 10001:10001 /home/appuser && \
    apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    npm install

EXPOSE 3000/tcp

USER 10001

CMD ["node", "index.js"]
