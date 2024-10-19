#!/usr/bin/env bash

# shellcheck source=./../framework.sh
source "$(dirname "$(realpath "$0")")/../framework.sh"
parse_arguments "$@"

mongodb_init_script=$(cat "$git_base_dir/scripts/database/mongodb-init.js")

compose_no_progress up -d mongodb

run_command_until_success "Awaiting MongoDB to become ready.." 10 \
    docker compose exec mongodb mongosh --eval "db.adminCommand('ping')"

run_verbose docker compose exec mongodb mongosh --eval "$mongodb_init_script"

print_success "MongoDB container has been set up."