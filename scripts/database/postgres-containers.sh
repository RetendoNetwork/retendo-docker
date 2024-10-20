#!/usr/bin/env bash

# shellcheck source=./../framework.sh
source "$(dirname "$(realpath "$0")")/../framework.sh"
parse_arguments "$@"

print_info "Setting up the Postgres container..."

POSTGRES_USER=$(grep 'POSTGRES_USER=' compose.yml | awk -F '=' '{print $2}' | tr -d ' ')
POSTGRES_PASSWORD=$(grep 'POSTGRES_PASSWORD=' compose.yml | awk -F '=' '{print $2}' | tr -d ' ')

postgres_init_script=$(cat "$git_base_dir/scripts/database/postgres-init.sh")

compose_no_progress up -d postgres
run_command_until_success "Awaiting Postgres to become ready.." 5 \
    docker compose exec postgres psql -U "$POSTGRES_USER" -c "\\l"

run_verbose docker compose exec postgres sh -c "$postgres_init_script"

compose_no_progress up -d postgres
if [[ $(docker compose exec postgres psql -At -U "$POSTGRES_USER" -d friends -c "SELECT 1 FROM information_schema.schemata WHERE schema_name = '3ds';") = "1" ]]; then
    print_info "Migrating friends to the nex-go rewrite.."
    friends_db=$(cat "$git_base_dir/scripts/database/friends-nex-go.sql")
    # shellcheck disable=SC2046
    docker compose exec postgres psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d friends -c "$friends_db" $(if_not_verbose --quiet)
fi

print_success "Postgres container is set up."