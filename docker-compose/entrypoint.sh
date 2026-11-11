#!/bin/sh
set -eu

if [ "${1:-}" = "php-fpm" ]; then
    if [ ! -f .env ]; then
        cp .env.example .env
    fi

    mkdir -p storage/app/private storage/app/public storage/framework/cache/data \
        storage/framework/sessions storage/framework/views storage/logs bootstrap/cache

    echo "Instalando dependencias PHP..."
    composer install --no-interaction --prefer-dist
    php artisan config:clear --no-interaction

    application_key=$(php -r 'require "vendor/autoload.php"; $environment = Dotenv\Dotenv::parse(file_get_contents(".env")); echo $environment["APP_KEY"] ?? "";')
    if [ -z "$application_key" ] && [ -z "${APP_KEY:-}" ]; then
        php artisan key:generate --no-interaction
    fi

    echo "Preparando tablas y usuarios iniciales..."
    php artisan migrate --no-interaction
    php artisan db:seed --no-interaction
    php artisan storage:link --no-interaction

    echo "Instalando y compilando el frontend..."
    npm ci --no-audit --no-fund
    npm run build

    echo "Entorno de desarrollo listo."
fi

exec docker-php-entrypoint "$@"
