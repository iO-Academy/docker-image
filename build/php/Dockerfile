FROM php:7.4-fpm
RUN apt-get update \
    && apt-get install -y zlib1g-dev libxml2-dev libssl-dev libzip-dev
RUN docker-php-ext-install -j$(nproc) pdo_mysql
RUN docker-php-ext-install -j$(nproc) zip
RUN docker-php-ext-install -j$(nproc) bcmath
RUN docker-php-ext-install -j$(nproc) calendar
RUN docker-php-ext-install -j$(nproc) soap
RUN docker-php-ext-install -j$(nproc) intl
