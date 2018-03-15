FROM orbits-nginx-entry

RUN apt-get install -y curl php7.0-fpm php7.0-cli
RUN ln -s /var/run /run
RUN mkdir /run/php
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD ./conf/php.nginx.conf /etc/nginx/sites-enabled/default

CMD service php7.0-fpm start && nginx -c /etc/nginx/nginx.conf -g "daemon off;"