FROM debian

WORKDIR /srv

RUN apt-get update && apt-get install -y --force-yes mongodb

CMD mongod --config /etc/mongodb.conf
