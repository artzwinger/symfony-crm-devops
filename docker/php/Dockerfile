FROM php:7.3.20-fpm-buster
ARG TIMEZONE
ARG XDEBUG_MODE=off
COPY docker/php/php.ini /usr/local/etc/php/conf.d/docker-php-config.ini

# Node 12 lts
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get update && apt-get install -y \
    gnupg \
    g++ \
    procps \
    openssl \
    git \
    unzip \
    zlib1g-dev \
    libzip-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libicu-dev  \
    libonig-dev \
    libxslt1-dev \
    libpq-dev \
    acl \
    postgresql-client \
    nodejs \
    cron \
    && echo 'alias sf="php bin/console"' >> ~/.bashrc

RUN docker-php-ext-configure gd

RUN docker-php-ext-install \
    pdo pdo_mysql zip xsl gd intl opcache exif mbstring pcntl soap pdo_pgsql xml dom sysvsem


# install xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# configure Symfony
RUN echo 'alias sf="php bin/console"' >> ~/.bashrc

# Set timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone \
    && printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini \
    && "date"

RUN curl -sS https://getcomposer.org/installer | php -- --version=1.10.19 --install-dir=/usr/local/bin --filename=composer \
    && composer --version \
    && composer global require hirak/prestissimo

RUN usermod -u 1000 www-data
RUN mkdir -p /home/www-data/.ssh && chown -R www-data:www-data /home/www-data
RUN usermod -d /home/www-data www-data

RUN chown -R www-data:www-data /var/www

COPY key /home/www-data/.ssh/id_rsa
RUN chown www-data:www-data /home/www-data/.ssh/id_rsa && chmod 0600 /home/www-data/.ssh/id_rsa
RUN echo "    IdentityFile /home/www-data/.ssh/id_rsa" >> /etc/ssh/ssh_config

USER www-data

RUN mkdir -p /home/www-data/.ssh
RUN touch /home/www-data/.ssh/known_hosts
RUN ssh-keyscan -H github.com >> /home/www-data/.ssh/known_hosts
RUN ssh-keyscan -H bitbucket.org >> /home/www-data/.ssh/known_hosts

RUN eval `ssh-agent -s` && ssh-add /home/www-data/.ssh/id_rsa \
    && git clone git@github.com:noctuasystems/tutorsoft.git /var/www/shop \
    && cd /var/www/shop \
    && composer install \
    && composer require google/recaptcha
#    && composer config repositories.progressive vcs git@github.com:artzwinger/teachers-progressive-bundle.git \
#    && composer require teachers/progressive-bundle

RUN cd /var/www/shop && npm install

RUN cd /var/www/shop && tar -czf vendor.tar.gz vendor
COPY docker/php/docker-php-entrypoint /usr/local/bin/
COPY docker/php/run-message-consumer /usr/local/bin/
COPY docker/php/run-websocket /usr/local/bin/

USER root

COPY docker/php/cron-command /etc/cron.d/oro-crontab
RUN chmod 0644 /etc/cron.d/oro-crontab && \
    crontab /etc/cron.d/oro-crontab

# configure xdebug
RUN echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.client_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN printf 'xdebug.mode=%s\n' ${XDEBUG_MODE} >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.discover_client_host=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

USER www-data

WORKDIR /var/www/shop
