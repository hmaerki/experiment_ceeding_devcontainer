# FROM ubuntu:22.04
FROM mcr.microsoft.com/devcontainers/base:ubuntu
# FROM mcr.microsoft.com/devcontainers/base:alpine-3.17

ENV TZ UTC

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential git gem ruby make gcc gdb valgrind vim && \
	apt-get clean && \
	rm -rf /var/cache/apt/archives/* && \
    rm -rf /var/lib/apt/lists/*
RUN cd /tmp/ && \
	git clone --recursive --depth=1 --single-branch --branch master https://github.com/ThrowTheSwitch/Ceedling ceedling && \
	cd ceedling && \
	gem build ceedling.gemspec && \
	gem install ceedling-*.gem && \
	cd /root/ && \
	rm -rf /tmp/ceedling

VOLUME /root/basic-ceedling-example
WORKDIR /root/basic-ceedling-example

CMD bash
