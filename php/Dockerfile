FROM php:7.4-fpm-alpine

RUN apk add --no-cache --virtual .build-deps \
	&& apk add --no-cache py3-pip autoconf build-base git zsh shadow curl make \
	acl file gettext git mariadb-client \
	coreutils freetype-dev icu-dev libjpeg-turbo-dev libpng-dev libtool \
	libwebp-dev libzip-dev mariadb-dev zlib-dev yarn \ 
    && docker-php-ext-install gd zip exif intl pdo_mysql opcache \
    && pip install supervisor \
    && pecl install xdebug apcu \
    && docker-php-ext-enable apcu opcache \
    && mkdir /app \
    && adduser -h /home/app -u 1000 -D app \
    && chown -R 1000 /app \
    && rm -rf /home/www-data \
    && rm -rf /usr/local/etc/php-fpm.d/*.conf \
    && apk del .build-deps

USER 1000

RUN cd \
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer 
COPY --chown=1000:1000 ./.zshrc /home/app/.zshrc
COPY ./supervisor/ /etc/supervisor/
COPY ./fpm.conf /usr/local/etc/php-fpm.d/fpm.conf
COPY ./fpm-xdebug.conf /usr/local/etc/php-fpm.d/fpm-xdebug.conf
COPY ./php.ini /usr/local/etc/php/php.ini
COPY ./php-cli.ini /usr/local/etc/php/php-cli.ini
COPY ./php-xdebug.ini /usr/local/etc/php/php-xdebug.ini

WORKDIR /app

CMD /usr/bin/supervisord

