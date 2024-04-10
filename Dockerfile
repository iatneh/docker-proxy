FROM registry:2
LABEL maintainer="xiayang1900@gmail.com"
ENV PROXY_REMOTE_URL="" \
    DELETE_ENABLED=""
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
