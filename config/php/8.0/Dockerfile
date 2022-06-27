FROM php:8.0-fpm-alpine
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
		sqlite
	RUN docker-php-ext-install soap sockets exif bcmath pdo_mysql pcntl
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