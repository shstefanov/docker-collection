FROM orbits_base_image

RUN apt-get install -y nginx

CMD nginx -c /etc/nginx/nginx.conf -g "daemon off;"