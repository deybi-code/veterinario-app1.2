RUN composer install --no-dev --optimize-autoloader

RUN npm install
RUN npm run build

RUN php artisan config:clear
RUN php artisan cache:clear
RUN php artisan route:clear
RUN php artisan view:clear

EXPOSE 8000

CMD php artisan serve --host=0.0.0.0 --port=8000
