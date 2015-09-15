# PROXY

Nginx proxy for api.test.ndla.no

# Building and distribution

## Create Docker Image
    ./build.sh

You need to have a docker daemon running locally. Ex: [boot2docker](http://boot2docker.io/)

## Deploy Docker Image to Amazon (via DockerHub)
    cd src/main/deploy  
    deployRemote.sh
