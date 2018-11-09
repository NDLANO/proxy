#!/bin/sh

function replace_env_variables {
    sed -i -- "s/NDLA_ENVIRONMENT/$NDLA_ENVIRONMENT/g" /etc/nginx/nginx.conf
}

function setup_nginx_caches {
    if [ $NDLA_ENVIRONMENT == "staging" ] || [ $NDLA_ENVIRONMENT == "prod" ]; then
	    ln -fs /etc/nginx/nginx-caches-prod.conf /etc/nginx/nginx-caches.conf
    else
        ln -fs /etc/nginx/nginx-caches-default.conf /etc/nginx/nginx-caches.conf
    fi
}

setup_env_variables

setup_nginx_caches

nginx -g 'daemon off;'
