#!/bin/sh

function is_kubernetes {
    [ -e "/var/run/secrets/kubernetes.io" ]
}

function replace_env_variables {
    sed -i -- "s/NDLA_ENVIRONMENT/${NDLA_ENVIRONMENT/_/-}/g" /etc/nginx/nginx.conf
}

function setup_nginx_caches {
    if [ $NDLA_ENVIRONMENT == "staging" ] || [ $NDLA_ENVIRONMENT == "prod" ] || [ $NDLA_ENVIRONMENT == "ff" ]; then
	    ln -fs /etc/nginx/nginx-caches-prod.conf /etc/nginx/nginx-caches.conf
    else
        ln -fs /etc/nginx/nginx-caches-default.conf /etc/nginx/nginx-caches.conf
    fi
}

function setup_dns_resolver {
    if is_kubernetes; then # Check whether we are running on kubernetes or not
        echo "resolver kube-dns.kube-system.svc.cluster.local;" > /nginx-resolver.conf
    else
        echo "resolver 127.0.0.11;" > /nginx-resolver.conf
    fi
}

function setup_frontend_hostnames {
    if is_kubernetes; then
        echo "set \$frontend 'ndla-frontend.default.svc.cluster.local';" > /ndla-frontend-hostname.conf
        echo "set \$frontend 'learningpath-frontend.default.svc.cluster.local';" >> /learningpath-frontend-hostname.conf
    else
        echo "set \$frontend 'ndla-frontend.ndla-local';" > /ndla-frontend-hostname.conf
        echo "set \$frontend 'learningpath-frontend.ndla-local';" >> /learningpath-frontend-hostname.conf
    fi
}

replace_env_variables

setup_nginx_caches

setup_dns_resolver

setup_frontend_hostnames

nginx -g 'daemon off;'
