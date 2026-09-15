# Composer is copied from the official image instead of downloaded at build time.
FROM composer:2 AS composer

# Base image: PHP 8.4 with Apache on Debian 12 Bookworm.
FROM php:8.4-apache-bookworm

LABEL maintainer='Christos Sidiropoulos <Christos.Sidiropoulos@uni-mannheim.de>'

## TYPO3 r13 ##
# This Dockerfile aims to install a working TYPO3 v13 instance which serves as a basisimage.

# Upgrade the system and install runtime dependencies:
RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
    # TYPO3 dependencies:
    ghostscript \
    graphicsmagick \
    graphicsmagick-imagemagick-compat \
    libfreetype6 \
    libicu72 \
    libjpeg62-turbo \
    libpng16-16 \
    libxml2 \
    libzip4 \
    locales \
    mariadb-client \
    # Composer dependencies:
    git \
    unzip \
    # for docker entrypoint:
    wait-for-it \
  # apache mods:
  && a2enmod headers \
  && a2enmod expires \
  && a2enmod rewrite \
  # Gen locales:
  && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
  && sed -i '/de_DE.UTF-8/s/^# //g' /etc/locale.gen \
  && locale-gen \
  # Install build dependencies and compile the required PHP modules:
  && apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) \
    exif \
    gd \
    intl \
    mysqli \
    opcache \
    pdo_mysql \
    xml \
    zip \
  # Remove the compiler toolchain and development headers from the final image:
  && apt-get purge -y --auto-remove \
    $PHPIZE_DEPS \
    libc6-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Install and setup Composer:
COPY --from=composer /usr/bin/composer /usr/local/bin/composer

# Install and setup Composer:
COPY --from=composer /usr/bin/composer /usr/local/bin/composer

# Install and setup TYPO3 & fix TYPO3 warnings/problems:
COPY typo3.conf /etc/apache2/sites-available/typo3.conf
WORKDIR /var/www/
RUN COMPOSER_ALLOW_SUPERUSER=1 composer create-project \
    --no-dev \
    --no-interaction \
    --no-progress \
    --prefer-dist \
    typo3/cms-base-distribution:^13.4 typo3 \
  && touch typo3/public/FIRST_INSTALL \
  # Add production php.ini:
  && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
  # Enable apache site configuration for TYPO3:
  && a2dissite 000-default \
  && a2ensite typo3 \
  # Add TYPO3 and OPcache settings:
  && printf '%s\n' \
    '; Settings for TYPO3' \
    'memory_limit=256M' \
    'max_execution_time=240' \
    'max_input_vars=1500' \
    'post_max_size=10M' \
    'upload_max_filesize=10M' \
    'pcre.jit=1' \
    'opcache.enable=1' \
    'opcache.enable_cli=1' \
    > /usr/local/etc/php/conf.d/99-typo3.ini \
  # Fix system locale not set on UTF-8 file system:
  && mkdir -p /var/www/typo3/config/system/ \
  && printf "%s\n" "<?php \$GLOBALS['TYPO3_CONF_VARS']['SYS']['systemLocale'] = 'de_DE.utf8';" > /var/www/typo3/config/system/additional.php \
  && chown -R www-data:www-data /var/www/

# Wait for dependencies before starting Apache:
COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/docker-entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
CMD ["apache2-foreground"]
