FROM php:8.1-apache

MAINTAINER John Gill
ENV REFRESHED_AT 2016-07-01

RUN apt-get update \
    && apt-get install -y libzip-dev libwebp-dev libpng-dev libjpeg-dev libxpm-dev libicu-dev libxml2-dev \
    && docker-php-ext-install zip gd intl soap

RUN pecl install channel://pecl.php.net/xmlrpc-1.0.0RC3  xmlrpc

# Install postgres dependencies
RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo_pgsql pgsql

RUN mkdir /var/www/moodledata

WORKDIR /var/www/html
COPY . /var/www/html
COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf

RUN chown -R www-data:www-data /var/www \
    && a2enmod rewrite

RUN echo 'max_input_vars = 20000' >>  /usr/local/etc/php/conf.d/php-ini-overrides.ini
