FROM nginx:1.14.0

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-caches-default.conf /etc/nginx/
COPY nginx-caches-prod.conf /etc/nginx/

COPY start-nginx.sh /start-nginx.sh

RUN chmod +x /start-nginx.sh

CMD ["/start-nginx.sh"]
