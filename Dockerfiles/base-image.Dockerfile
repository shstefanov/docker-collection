# Creating base image from latest Debian

FROM debian

RUN apt-get update

WORKDIR /srv

RUN apt-get update
