#!/bin/sh

function is_kubernetes {
    [ -e "/var/run/secrets/kubernetes.io" ]
}

function setup_hostnames {
    if [ is_kubernetes ]; then
	    ln -fs /etc/nginx/new-hostnames.conf /etc/nginx/hostnames.conf
    else
	    ln -fs /etc/nginx/old-hostnames.conf /etc/nginx/hostnames.conf
    fi
}

function replace_env_variables {
    sed -i -- "s/NDLA_ENVIRONMENT/$NDLA_ENVIRONMENT/g" /etc/nginx/nginx.conf
    sed -i -- "s/NDLA_ENVIRONMENT/$NDLA_ENVIRONMENT/g" /etc/nginx/hostnames.conf
}

function setup_nginx_caches {
    if [ $NDLA_ENVIRONMENT == "staging" ] || [ $NDLA_ENVIRONMENT == "prod" ]; then
	    ln -fs /etc/nginx/nginx-caches-prod.conf /etc/nginx/nginx-caches.conf
    else
        ln -fs /etc/nginx/nginx-caches-default.conf /etc/nginx/nginx-caches.conf
    fi
}

function setup_dns_resolver {
    if is_kubernetes; then # Check whether we are running on kubernetes or not
        echo "resolver kube-dns.kube-system.svc.cluster.local;" > /etc/nginx/nginx-resolver.conf
    else
        echo "resolver 127.0.0.11;" > /etc/nginx/nginx-resolver.conf
    fi
}


setup_hostnames
replace_env_variables
setup_nginx_caches
setup_dns_resolver

nginx -g 'daemon off;'
