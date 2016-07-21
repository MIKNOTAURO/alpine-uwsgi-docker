FROM python:2.7.12-alpine

RUN apk add --update \
    nginx \
    supervisor \
    uwsgi-python \
        && rm -rf /var/cache/apk/*

ENV APP_DIR /app

RUN mkdir ${APP_DIR} \
	&& chown -R nginx:nginx ${APP_DIR} \
	&& chmod 777 /run/ -R \
	&& chmod 777 /root/ -R
VOLUME [${APP_DIR}]
WORKDIR ${APP_DIR}

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-site.conf /etc/nginx/conf.d/
COPY supervisord.conf /etc/supervisord.conf

COPY ./app /app
WORKDIR /app

EXPOSE 80

CMD ["/usr/bin/supervisord"]
