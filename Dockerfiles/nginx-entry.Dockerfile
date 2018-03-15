FROM orbits-base-image

RUN apt-get install -y nginx

ADD ./conf/entry.nginx.conf /etc/nginx/sites-enabled/default

CMD nginx -c /etc/nginx/nginx.conf -g "daemon off;"