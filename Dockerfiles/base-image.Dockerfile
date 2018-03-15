# Creating base image from latest Debian

FROM debian

WORKDIR /srv

RUN apt-get update
