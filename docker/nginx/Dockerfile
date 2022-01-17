FROM nginx:1.17.8-alpine

COPY docker/nginx/nginx.conf  /etc/nginx/
COPY docker/nginx/default.conf /etc/nginx/conf.d/
RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN set -x ; \
  addgroup -g 1000 -S www-data ; \
  adduser -u 1000 -D --home /home/www-data -S -G www-data www-data && exit 0 ; exit 1

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

RUN mkdir -p /home/www-data/.ssh && chown -R www-data:www-data /home/www-data
RUN mkdir -p /var/www
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
    && cd /var/www/shop

USER root

EXPOSE 80
EXPOSE 443
