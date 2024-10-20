#!/usr/bin/env bash

# shellcheck source=./framework.sh
source "$(dirname "$(realpath "$0")")/framework.sh"
set_description "This file is for creating environment for all game servers."
add_option_with_value "-s --server-ip" "server_ip" "ip-address" "The IP address of the Retendo Network server (must be accessible to the clients)" false
add_option "-n --no-environment" "no_environment" "Disables reading existing configuration values from .env"
add_option "-f --force" "force" "Skip the confirmation prompt and always overwrite existing local environment files"
parse_arguments "$@"

generate_password() {
    length=$1
    head /dev/urandom | LC_ALL=C tr -dc "A-Za-z0-9@#$%&*" | head -c "$length"
}

generate_hex() {
    length=$1
    head /dev/urandom | LC_ALL=C tr -dc "A-F0-9" | head -c "$length"
}

if [[ -z "$server_ip" ]]; then
    print_error "No server IP address found, please provide one"
    exit 1
fi

pikmin3_kerberos_password=$(generate_password 32)
account_grpc_api_key=$(generate_password 32)

compose_file="compose.yml"

if [ -f "$compose_file" ]; then
    # PIKMIN ENV SERVER
    sed -i "s/PN_PIKMIN3_SECURE_SERVER_HOST=.*/PN_PIKMIN3_SECURE_SERVER_HOST=${account_grpc_api_key}/" "$compose_file"  
    sed -i "s|PN_PIKMIN3_POSTGRES_URI=.*|PN_PIKMIN3_POSTGRES_URI=postgres://postgres_pretendo:${pikmin3_kerberos_password}@postgres/pikmin3?sslmode=disable|" "$compose_file"
    sed -i "s/PN_PIKMIN3_KERBEROS_PASSWORD=.*/PN_PIKMIN3_KERBEROS_PASSWORD=${pikmin3_kerberos_password}/" "$compose_file" 
    sed -i "s/PN_PIKMIN3_SECURE_SERVER_HOST=.*/PN_PIKMIN3_SECURE_SERVER_HOST=${server_ip}/" "$compose_file"   
else
    print_error "The file $compose_file doesn't exist."
fi