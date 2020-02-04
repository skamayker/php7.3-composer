FROM php:7.3
COPY --from=composer:1.9 /usr/bin/composer /usr/bin/composer

RUN apt-get update \
    && apt-get install -y -qq --no-install-recommends \
        nginx \
        libzip-dev \
        unzip \
        zlib1g-dev \
        libicu-dev \
        g++ \
        git \
        libpng-dev\
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && docker-php-ext-install \
        intl \
        exif \
        zip \
        pcntl \
        pdo_mysql \
        bcmath \
        opcache \
        gd \
    && pecl install \
        apcu \
        igbinary \
    && docker-php-ext-enable \
        apcu \
        igbinary \
     && composer global require "hirak/prestissimo:^0.3"
