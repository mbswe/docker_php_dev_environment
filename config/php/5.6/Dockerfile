FROM php:5.6-fpm-alpine
LABEL maintainer="Magnus Berntsson <magnus@magnus.tech>"

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer