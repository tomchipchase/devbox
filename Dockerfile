FROM alpine:latest

RUN apk add  --no-cache docker
RUN apk add --no-cache python2 py-pip && pip install --upgrade docker-compose && apk del --no-cache py-pip
