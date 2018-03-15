FROM orbits-nginx-entry

RUN apt-get install -y php7.0-fpm php7.0-cli 
RUN ln -s /var/run /run
RUN mkdir /run/php

ADD ./conf/php.nginx.conf /etc/nginx/sites-enabled/default

# CMD service php7.0-fpm start
CMD service php7.0-fpm start && nginx -c /etc/nginx/nginx.conf -g "daemon off;"