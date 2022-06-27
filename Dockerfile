# Install PHP 7.4 with Apache2 on Debian 11 bullseye:
FROM php:7.4-apache 

LABEL maintainer='Christos Sidiropoulos <Christos.Sidiropoulos@uni-mannheim.de>'

ENV DB_ADDR=localhost
ENV DB_PORT=3306

EXPOSE 80

## TYPO3 r11 ##
# This Dockerfile aimes to install a working typo3 v11 instance which serves as a basisimage. 
# Based on this guide: https://github.com/UB-Mannheim/kitodo-presentation/wiki

# Workaround for "E: Package 'php-XXX' has no installation candidate" from https://hub.docker.com/_/php/ :
RUN rm /etc/apt/preferences.d/no-debian-php

#For baseimages other than php:7.4-apache:
#RUN apt-get install -y apache2 

# Upgrade system and install further php dependencies & composer & image processing setup:
RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
    mariadb-client \
    libapache2-mod-php \
    php-curl \
    php-gd \
    php-intl \
    php-mysql \
    php-xml \
    php-zip \
    ghostscript \
    graphicsmagick \
    graphicsmagick-imagemagick-compat \
    git \
    unzip \
  # newest composer version:    
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php --install-dir /usr/bin --filename composer \
  && php -r "unlink('composer-setup.php');" \
  # cleanup:
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install and setup Typo3 & fix Typo3 warnings/problems:
WORKDIR /var/www/
RUN composer create-project typo3/cms-base-distribution:^11 typo3 \
  && touch typo3/public/FIRST_INSTALL \
  && chown -R www-data: typo3 \
  && cd html \
  && ln -s ../typo3/public/* . \
  && a2enmod php7.4 \
  && echo '<Directory /var/www/html>\n  AllowOverride All\n</Directory>' >> /etc/apache2/sites-available/typo3.conf \
  && a2ensite typo3 \
  # Fixing Low PHP script execution time & PHP max_input_vars very low:
  && echo ';Settings for Typo3: \nmax_execution_time=240 \nmax_input_vars=1500' >> /etc/php/7.4/mods-available/typo3.ini \
  && echo 'xdebug.max_nesting_level = 500' >> /etc/php/7.4/apache2/conf.d/20-xdebug.ini \
  && phpenmod typo3 \
  && service apache2 restart

# Copy startup script into the container:
COPY docker-entrypoint.sh /
# Run startup script & start apache2 (https://github.com/docker-library/php/blob/master/7.4/bullseye/apache/apache2-foreground)
CMD /docker-entrypoint.sh & apache2-foreground 