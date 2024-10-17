#!/usr/bin/env bash

# shellcheck source=./framework.sh
source "$(dirname "$(realpath "$0")")/framework.sh"
set_description "This files is a containers for have nginx server on docker."
parse_arguments "$@"

docker compose pull
docker compose build
docker compose up

print_sucesss "Nginx and other all server is active."