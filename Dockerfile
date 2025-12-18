# Baseimage PHP 8.3 with Apache2 on Debian 11 bullseye:
FROM php:8.3-apache

LABEL maintainer='Christos Sidiropoulos <Christos.Sidiropoulos@uni-mannheim.de>'

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

## TYPO3 r11 ##
# This Dockerfile aimes to install a working TYPO3 v11 instance which serves as a basisimage.
# Based on this guide: https://github.com/UB-Mannheim/kitodo-presentation/wiki

# Upgrade system and install further php dependencies & composer & image processing setup:
RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
    mariadb-client \
    locales \
    # for PHP modules:
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmagickwand-dev \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    libcurl4-openssl-dev \
    # TYPO3 dependencies:
    ghostscript \
    graphicsmagick \
    graphicsmagick-imagemagick-compat \
    # for newest composer version:
    git \
    unzip \
    # for docker entrypoint:
    wait-for-it \
  # newest composer version:
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php --install-dir /usr/bin --filename composer \
  && php -r "unlink('composer-setup.php');" \
  # cleanup:
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  # apache mods:
  && a2enmod headers \
  && a2enmod expires \
  && a2enmod rewrite \
  # Gen locales:
  && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
  && sed -i '/de_DE.UTF-8/s/^# //g' /etc/locale.gen \
  && locale-gen

# Install required PHP modules
 RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) \
    # curl \
    gd \
    intl \
    mysqli \
    opcache \
    xml \
    zip

# Install and setup TYPO3 & fix TYPO3 warnings/problems:
WORKDIR /var/www/
RUN export COMPOSER_ALLOW_SUPERUSER=1 \
  && composer create-project --no-install --no-interaction --no-security-blocking typo3/cms-base-distribution:^11 typo3 \
  && composer config --working-dir typo3/ --no-plugins allow-plugins.helhum/typo3-console-plugin true \
  && composer update --working-dir typo3/ --no-interaction --no-security-blocking \
  && touch typo3/public/FIRST_INSTALL \
  && chown -R www-data: typo3 \
  && cd html \
  && ln -s ../typo3/public/* . \
  && ln -s ../typo3/public/.htaccess \
  # Add production php.ini:
  && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \ 
  # Enable opcache:
  && sed -i "s/opcache.enable = .*/opcache.enable = 1/" /usr/local/etc/php/php.ini \
  && sed -i "s/opcache.enable_cli = .*/opcache.enable_cli = 1/" /usr/local/etc/php/php.ini \
  && echo '<Directory /var/www/html>\n  AllowOverride All\n</Directory>' >> /etc/apache2/sites-available/typo3.conf \
  && a2ensite typo3 \
  && sed -i '12a UseCanonicalName On' /etc/apache2/sites-available/000-default.conf \
  # Fixing Low PHP script execution time & PHP max_input_vars very low:
  && echo ';Settings for TYPO3: \nmax_execution_time=240 \nmax_input_vars=1500' >> /usr/local/etc/php/conf.d/99-typo3.ini \
  && echo 'xdebug.max_nesting_level = 500' >> /usr/local/etc/php/conf.d/98-xdebug.ini \
  && chown -R www-data:www-data .

# Copy startup script into the container:
COPY docker-entrypoint.sh /
# Fix wrong line endings in the startup script and make it executable:
RUN sed -i.bak 's/\r$//' /docker-entrypoint.sh && chmod +x /docker-entrypoint.sh

# Run startup script & start apache2 (https://github.com/docker-library/php/blob/master/8.3/bullseye/apache/apache2-foreground)
CMD /docker-entrypoint.sh & apache2-foreground