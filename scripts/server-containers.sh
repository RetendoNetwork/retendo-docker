#!/usr/bin/env bash

# shellcheck source=./framework.sh
source "$(dirname "$(realpath "$0")")/framework.sh"
set_description "This files is a containers for have nginx server on docker."
parse_arguments "$@"