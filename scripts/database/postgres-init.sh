#!/usr/bin/env bash

# shellcheck source=./../framework.sh
source "$(dirname "$(realpath "$0")")/../framework.sh"
set_description "This file is for create a postgres database with php file for retendo network."
parse_arguments "$@"

print_info "Creating postgres database.."

read -p "Enter the host of PostgreSQL (default host: 'localhost') : " host
host=${host:-localhost}

read -p "Enter the port of PostgreSQL (default port: '5432') : " port
port=${port:-5432}

read -p "Enter the username PostgreSQL : " user
read -sp "Enter the password of PostgreSQL : " password
print_info

read -p "Enter the name of the new database : " dbname

PHP_FILE="./postgres-db.php"

php -r "\$host='$host'; \$port='$port'; \$user='$user'; \$password='$password'; \$dbname='$dbname'; require '$PHP_FILE';"

if [ $? -eq 0 ]; then
    print_success "PostgreSQL database created sucessfully !"
else
    print_error "Error for create PostgreSQL database."
fi