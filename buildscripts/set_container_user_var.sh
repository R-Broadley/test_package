#!/bin/sh

if [ "$(uname)" = "Linux" ]
then
	CONTAINER_USER="${CONTAINER_USER:-$(id -u):$(id -g)}"
else
	CONTAINER_USER="${CONTAINER_USER:-1000:1000}"
fi

export CONTAINER_USER
