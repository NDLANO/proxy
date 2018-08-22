#!/bin/sh

function setup_nginx_caches {
    if [ $NDLA_ENVIRONMENT == "staging" ] || [ $NDLA_ENVIRONMENT == "prod" ]; then
	    ln -fs /etc/nginx/nginx-caches-prod.conf /etc/nginx/nginx-caches.conf
    else
        ln -fs /etc/nginx/nginx-caches-default.conf /etc/nginx/nginx-caches.conf
    fi
}

setup_nginx_caches

nginx -g 'daemon off;'
