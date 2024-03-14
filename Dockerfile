FROM registry:2
LABEL maintainer="registry-proxy Docker Maintainers https://hsiaa.top"
ENV PROXY_REMOTE_URL="" \
    DELETE_ENABLED=""
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh