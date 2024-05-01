FROM php:8.2-cli as php_base

RUN apt-get update && apt-get install -y postgresql-client

COPY --from=mlocati/php-extension-installer:2.1.81 /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer/composer:2.7.4-bin /composer /usr/bin/composer
COPY --from=ghcr.io/roadrunner-server/roadrunner:2024.1 /usr/bin/rr /usr/bin/rr

RUN install-php-extensions pdo_pgsql pgsql zip sockets opcache apcu redis http bcmath