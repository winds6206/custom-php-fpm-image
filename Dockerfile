FROM php:7.2-fpm
MAINTAINER Tony_Jhang

# install php zip Extension
RUN apt-get update && apt-get install -y \
  libzip-dev \
  zip \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip

RUN docker-php-ext-install \
  mysqli \
  pdo \
  pdo_mysql

# install php Redis Extension
RUN pecl install redis \
   &&  rm -rf /tmp/pear \
   &&  docker-php-ext-enable redis

COPY ./php.ini /usr/local/etc/php/
COPY ./www.conf /usr/local/etc/php-fpm.d/

ARG TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
