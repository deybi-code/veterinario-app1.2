FROM php:8.5-cli

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libsqlite3-dev

RUN docker-php-ext-install pdo pdo_sqlite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY --from=node:22 /usr/local/bin/node /usr/local/bin/node
COPY --from=node:22 /usr/local/lib/node_modules /usr/local/lib/node_modules

RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

WORKDIR /app

COPY . .

RUN composer install --no-dev --optimize-autoloader

RUN npm install

RUN npm run build

EXPOSE 10000

CMD php artisan serve --host=0.0.0.0 --port=${PORT:-10000}
