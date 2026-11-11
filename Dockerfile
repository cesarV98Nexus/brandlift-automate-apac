FROM php:8.5-fpm-alpine

ARG user=developer
ARG uid=1000

RUN apk --no-cache add \
    curl \
    git \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    oniguruma-dev \
    sqlite-dev \
    nodejs \
    npm \
    zip \
    unzip \
    shadow

RUN docker-php-ext-install pdo_mysql gd zip

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer
COPY docker-compose/entrypoint.sh /usr/local/bin/brandlift-entrypoint
RUN chmod +x /usr/local/bin/brandlift-entrypoint

RUN useradd -G www-data -u "$uid" -d "/home/$user" "$user"
RUN mkdir -p /home/$user/.composer /var/www/node_modules && \
    chown -R $user:$user /home/$user /var/www

WORKDIR /var/www

USER $user

ENTRYPOINT ["brandlift-entrypoint"]
CMD ["php-fpm"]
