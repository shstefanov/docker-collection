FROM orbits-nginx-entry

# Install PHP 7.1
RUN apt-get install -y wget apt-transport-https apt-utils
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN sh -c 'echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list'
RUN apt update
RUN apt-get install -y curl php7.1-fpm php7.1-cli php7.1-mysql php7.1-opcache php7.1-curl php7.1-common php7.1-mbstring php7.1-xml php7.1-zip
RUN ln -s /var/run /run
RUN mkdir /run/php

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Adding config for handlig php with nginx
ADD ./conf/php.nginx.conf /etc/nginx/sites-enabled/default


# Command to run
# 1 - chown /srv/storage to grant write permissions to laravel application for this folder
# 2 - Start php-fpm service
# 3 - Start nginx in command line mode to keep container running
CMD chown -R www-data:www-data /srv/storage && service php7.1-fpm start && nginx -c /etc/nginx/nginx.conf -g "daemon off;"