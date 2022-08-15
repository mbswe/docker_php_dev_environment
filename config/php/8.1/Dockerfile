FROM php:8.1-fpm-alpine
LABEL maintainer="Magnus Berntsson <magnus@magnus.tech>"

# Install gd, iconv, mbstring, mysql, soap, sockets, zip, and zlib extensions
RUN apk add --update \
		$PHPIZE_DEPS \
		freetype-dev \
		git \
		libjpeg-turbo-dev \
		libpng-dev \
		libxml2-dev \
		libzip-dev \
		openssh-client \
        php8-gd \
		php8-json \
		php8-openssl \
		php8-pdo \
		php8-gd \
		php8-pdo_mysql \
		php8-session \
		php8-simplexml \
		php8-tokenizer \
		php8-xml \
		php8-iconv \
		imagemagick \
		imagemagick-libs \
		imagemagick-dev \
		php8-pcntl \
		php8-zip \
		sqlite \
	&& docker-php-ext-install soap sockets exif bcmath pdo_mysql pcntl \
	&& docker-php-ext-configure gd --with-jpeg --with-freetype \
	&& docker-php-ext-install gd \
	&& docker-php-ext-install zip

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