#!/usr/bin/env bash

# shellcheck source=./../framework.sh
source "$(dirname "$(realpath "$0")")/../framework.sh"
parse_arguments "$@"

generate_password() {
    length=$1
    head /dev/urandom | LC_ALL=C tr -dc "a-zA-Z0-9" | head -c "$length"
}

postgres_password=$(generate_password 32)

compose_file="compose.yml"

if [ -f "$compose_file" ]; then
    sed -i "s/POSTGRES_PASSWORD=.*/POSTGRES_PASSWORD=${postgres_password}/" "$compose_file"
else
    print_error "The file $compose_file doesn't exist."
fi

cat >"$git_base_dir/database-user.txt" <<EOF
Retendo Network database user server
====================================

Postgres username: postgres_retendo
Postgres password: $postgres_password
EOF

print_success "The password for PostgreSQL has been successfully generated !"