FROM orbits-php-entry

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Adding config for handlig laravel app with nginx
ADD ./conf/laravel.nginx.conf /etc/nginx/sites-enabled/default

# Command to run
# 1 - chown /srv/storage to grant write permissions to laravel application for this folder
# 2 - Start php-fpm service
# 3 - Start nginx in command line mode to keep container running
CMD chown -R www-data:www-data /srv/storage && service php7.1-fpm start && nginx -c /etc/nginx/nginx.conf -g "daemon off;"