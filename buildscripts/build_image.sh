#!/bin/sh

BUILDSCRIPTS="$(dirname "$0")"
source "$BUILDSCRIPTS/set_container_user_var.sh"

docker-compose build $1
