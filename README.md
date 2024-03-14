# 准备自定义镜像

## 构建docker镜像
~~~shell
docker build -t iatneh1900/docker-proxy .
~~~
## 推送到docker hub
~~~shell
## 如果未登录先登录
docker login

docker push iatneh1900/docker-proxy
~~~

# docker-compose运行

~~~yaml
version: '3.8'
services:
  registry-dockerhub:
    restart: always
    image: iatneh1900/docker-proxy
    hostname: registry-dockerhub
    container_name: registry-dockerhub
    network_mode: bridge
    user: '0'
    environment:
      - TZ=Asia/Shanghai
      - PROXY_REMOTE_URL=https://registry-1.docker.io
    ports:
      - 5000:5000
    volumes:
      - ./data/dh:/var/lib/registry
~~~


# 配置github Actions自动构建推送到Docker Hub

## 准备

> 准备DockerHub的AccessToken
1. [登录DockerHub](hub.docker.com)
2. My Account -> Security -> New Access Token

> 在GitHub`repository`配置DockerHub的账号和AccessToken
1. 进入对应的配置页面 例如：https://github.com/{username}/{repository}/settings/secrets/actions
2. 新建两个密钥 `DOCKERHUB_USERNAME` `DOCKERHUB_TOKEN` 分别对应DockerHub的 AccountID和AccessToken

## 配置action

~~~yaml
name: Docker Image CI

on:
  push:
    branches: [ "master" ]
  pull_request:
    branches: [ "master" ]
jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      -
        name: Set up QEMU
        uses: docker/setup-qemu-action@v3
      -
        name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
      -
        name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      -
        name: Build and push
        uses: docker/build-push-action@v5
        with:
          push: true
          tags: iatneh1900/docker-proxy:latest
~~~