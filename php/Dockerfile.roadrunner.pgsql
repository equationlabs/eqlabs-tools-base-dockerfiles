FROM php:8.2-cli as php_base
ENV  COMPOSER_ALLOW_SUPERUSER 1

# Install postgresql-client
RUN apt-get update && apt-get install -y postgresql-client

# Install roadrunner and composer and php-extension-installer
COPY --from=mlocati/php-extension-installer:2.1.81 /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer/composer:2.7.4-bin /composer /usr/bin/composer
COPY --from=ghcr.io/roadrunner-server/roadrunner:2023.3.9 /usr/bin/rr /usr/bin/rr

# Install php extensions
RUN install-php-extensions pdo_pgsql pgsql zip sockets opcache apcu redis http bcmath xdebug protobuf

# for roadrunner we need to enable opcache for cli
RUN echo "[opcache] \nopcache.enable_cli=1 \nopcache.preload=/opt/config/preload.php \nopcache.preload_user=root" | tee "$PHP_INI_DIR/conf.d/opcache-cli.ini"
# enable xdebug coverage
RUN echo "xdebug.mode=coverage" | tee -a "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini"
