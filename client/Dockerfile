FROM debian:buster-slim

ARG VCS_REF
ARG VCS_VERSION

LABEL maintainer="Rober Jarosz"  \
    org.label-schema.name="test client" \
    #org.label-schema.description="" \
    #org.label-schema.url="github" \
    #org.label-schema.vcs-ref=$VCS_REF \
    #org.label-schema.vcs-url="github" \
    #org.label-schema.version=$VCS_VERSION \
    org.label-schema.schema-version="0.1"

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update -q --fix-missing && \
    apt-get -y upgrade && \
    apt-get -y install bash git net-tools vim less iputils-ping procps dnsutils mailutils\ 
        netcat
RUN mkdir -p /home/user \
	&& mkdir -p /home/user/.ssh \
	&& mkdir -p /home/user/data \
	&& mkdir -p /home/user/pubkeys

WORKDIR /home/user

#COPY run.sh ./
#COPY set_client.sh ./

VOLUME /home/user/data
VOLUME /home/user/.ssh
VOLUME /home/user/pubkeys
VOLUME /data/scripts



ENTRYPOINT ["/data/scripts/run.sh"]

