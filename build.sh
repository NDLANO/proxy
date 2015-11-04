#!/bin/sh

if ! git diff-index --quiet HEAD --; then
    echo "You have uncommited changes in your git repo. Commit before building"
    exit 1
fi

source ./build.properties

PROJECT=ndla/proxy
VER=v0.1
GIT_HASH=`git log --pretty=format:%h -n 1`

VERSION=${VER}_${GIT_HASH}

docker build -t $PROJECT:$VERSION .
