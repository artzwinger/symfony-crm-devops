FROM nginx:1.17.8-alpine

COPY docker/nginx/nginx.conf  /etc/nginx/
COPY docker/nginx/default.conf /etc/nginx/conf.d/
RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN set -x ; \
  addgroup -g 1000 -S www-data ; \
  adduser -u 1000 -D -S -G www-data www-data && exit 0 ; exit 1
  
EXPOSE 80
EXPOSE 443
