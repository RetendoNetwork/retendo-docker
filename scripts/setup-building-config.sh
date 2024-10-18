#!/usr/bin/env bash

# shellcheck source=./framework.sh
source "$(dirname "$(realpath "$0")")/framework.sh"
set_description "This file is for building all config for Retendo Network server."
parse_arguments "$@"

node ./config/boss-config.js
node ./config/website-config.js