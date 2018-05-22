FROM orbits-nginx-entry

ENV PHP_VERSION 7.1

# Install PHP 7.2
RUN apt-get install -y wget \
	apt-transport-https\
	apt-utils

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN sh -c 'echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list'
RUN apt update
RUN apt-get install -y \
	curl \
	php7.2-fpm \
	php7.2-cli \
	php7.2-mysql \
	php7.2-pgsql \
	php7.2-opcache \
	php7.2-curl \
	php7.2-common \
	php7.2-mbstring \
	php7.2-xml \
	php7.2-zip

RUN ln -s /var/run /run
RUN mkdir /run/php

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Adding config for handlig php with nginx

ADD ./conf/php.nginx.conf /etc/nginx/sites-enabled/default


# Command to run
# 1 - Start php-fpm service
# 2 - Start nginx in command line mode to keep container running
CMD service php7.2-fpm start && nginx -c /etc/nginx/nginx.conf -g "daemon off;"