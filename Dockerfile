FROM nginx:1.25.3-alpine-slim

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-caches-default.conf /etc/nginx/
COPY nginx-caches-prod.conf /etc/nginx/
COPY nginx-cacheless.conf /etc/nginx/

COPY start-nginx.sh /start-nginx.sh

RUN chmod +x /start-nginx.sh

CMD ["/start-nginx.sh"]
