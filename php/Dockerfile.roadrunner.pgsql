ARG PHP_VERSION=${version:-8.2}

FROM php:${PHP_VERSION}-cli-alpine AS php_base
# Install dependencies and php extensions
COPY --from=mlocati/php-extension-installer:2.6.4 /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions pdo_pgsql pgsql zip sockets opcache apcu redis http bcmath


FROM php_base AS php_roadrunner_mysql
ENV  COMPOSER_ALLOW_SUPERUSER=1

# Install roadrunner and composer
COPY --from=composer/composer:2.8.2-bin /composer /usr/bin/composer
COPY --from=ghcr.io/roadrunner-server/roadrunner:2024 /usr/bin/rr /usr/bin/rr

# for roadrunner we need to enable opcache for cli
RUN echo "opcache.enable_cli=1" | tee -a "$PHP_INI_DIR/conf.d/opcache-cli.ini"
RUN echo "opcache.preload=/opt/config/preload.php" | tee -a "$PHP_INI_DIR/conf.d/opcache-cli.ini"
RUN echo "opcache.preload_user=root" | tee -a "$PHP_INI_DIR/conf.d/opcache-cli.ini"