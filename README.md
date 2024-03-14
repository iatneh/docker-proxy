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