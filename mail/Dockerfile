FROM debian:buster-slim

ARG VCS_REF
ARG VCS_VERSION

LABEL maintainer="Rober Jarosz"  \
    org.label-schema.name="Postfix" \
    org.label-schema.description="basic smtp for phabricator" \
    #org.label-schema.url="github" \
    #org.label-schema.vcs-ref=$VCS_REF \
    #org.label-schema.vcs-url="github" \
    #org.label-schema.version=$VCS_VERSION \
    org.label-schema.schema-version="0.1"

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update -q --fix-missing && \
    apt-get -y upgrade && \
    apt-get -y install postfix vim bash less net-tools mailutils \
        iproute2 dnsutils iputils-ping dovecot-core dovecot-imapd \
        netcat bash-completion apache2 curl

RUN pwd

COPY entrypoint.sh /sbin/entrypoint.sh

EXPOSE 25

ENTRYPOINT ["/sbin/entrypoint.sh"]


