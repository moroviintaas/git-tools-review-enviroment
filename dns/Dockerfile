FROM debian:buster-slim
#Code modyfication of sameersbn's docker-bind (https://github.com/sameersbn/docker-bind)

ARG DEBIAN_FRONTEND=nointeractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update -q --fix-missing && \
    apt-get -y upgrade && \
    apt-get install -y \
    bind9 bind9-host dnsutils

ENV BIND_USER=bind\
    DATA_DIR=/data

COPY entrypoint.sh /sbin/entrypoint.sh



RUN chmod 755 /sbin/entrypoint.sh

VOLUME /data

EXPOSE 53/udp 53/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD [/"usr/sbin/named"]
