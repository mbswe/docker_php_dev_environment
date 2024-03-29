FROM php:7.4-fpm-alpine
LABEL maintainer="Magnus Berntsson <magnus@magnus.tech>"

# Install gd, iconv, mbstring, mysql, soap, sockets, zip, and zlib extensions
RUN apk add -U php7-dev --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
RUN apk add --update --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
		$PHPIZE_DEPS \
		freetype-dev \
		git \
		libjpeg-turbo-dev \
		libpng-dev \
		libxml2-dev \
		libzip-dev \
		openssh-client \
		php7-json \
		php7-openssl \
		php7-pdo \
		php7-gd \
		php7-pdo_mysql \
		php7-session \
		php7-simplexml \
		php7-tokenizer \
		php7-xml \
		php7-iconv \
		imagemagick \
		imagemagick-libs \
		imagemagick-dev \
		php7-imagick \
		php7-pcntl \
		php7-mysqli \
		php7-zip \
		sqlite
RUN docker-php-ext-install soap
RUN docker-php-ext-install sockets
RUN docker-php-ext-install exif
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pcntl
RUN docker-php-ext-configure gd --with-jpeg --with-freetype
RUN docker-php-ext-install gd
RUN docker-php-ext-install zip

RUN printf "\n" | pecl install \
		imagick && \
		docker-php-ext-enable --ini-name 20-imagick.ini imagick

RUN printf "\n" | pecl install \
		pcov && \
		docker-php-ext-enable pcov

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

RUN echo "sendmail_path=/usr/sbin/sendmail -S mailhog:1025" >> /usr/local/etc/php/conf.d/php-sendmail.ini

# Add xdebug
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS
RUN apk add --update linux-headers
RUN pecl install xdebug-3.1.5
RUN docker-php-ext-enable xdebug
RUN apk del -f .build-deps

# Configure Xdebug
RUN echo "zend_extension=xdebug.so" >> /usr/local/etc/php/conf.d/xdebug.ini \
	&& echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
	&& echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
	&& echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/xdebug.ini \
	&& echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.client_port=9001" >> /usr/local/etc/php/conf.d/xdebug.ini