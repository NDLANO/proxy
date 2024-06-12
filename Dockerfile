FROM nginx:1.26.1-alpine-slim

COPY start-nginx.sh /start-nginx.sh
RUN chmod +x /start-nginx.sh

COPY nginx-caches-default.conf /etc/nginx/
COPY nginx-caches-prod.conf /etc/nginx/
COPY nginx-cacheless.conf /etc/nginx/
COPY nginx.conf /etc/nginx/nginx.conf

CMD ["/start-nginx.sh"]
