FROM php:7.1-apache
MAINTAINER Shane Mc Cormack <dataforce@dataforce.org.uk>

WORKDIR /var/www

RUN \
  a2enmod rewrite && \
  apt-get update && apt-get install -y git unzip libmcrypt-dev libz-dev libmemcached-dev && \
  docker-php-source extract && \
  docker-php-ext-install bcmath && \
  docker-php-ext-install mcrypt && \
  docker-php-ext-install pdo_mysql && \
  yes '' | pecl install -f memcached && \
  echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini && \
  docker-php-source delete && \
  curl -sS https://getcomposer.org/installer | php -- --no-ansi --install-dir=/usr/bin --filename=composer

COPY errors.ini /usr/local/etc/php/conf.d/errors.ini

EXPOSE 80
