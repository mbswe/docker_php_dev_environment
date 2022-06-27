FROM php:5.6-fpm-alpine
LABEL maintainer="Magnus Berntsson <magnus@magnus.tech>"

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

RUN echo "sendmail_path=/usr/sbin/sendmail -S mailhog:1025" >> /usr/local/etc/php/conf.d/php-sendmail.ini