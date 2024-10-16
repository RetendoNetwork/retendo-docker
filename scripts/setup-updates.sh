#!/usr/bin/env bash

# shellcheck source=./framework.sh
source "$(dirname "$(realpath "$0")")/framework.sh"
set_description "This file is intended to have the latest updates from retendo-docker."
parse_arguments "$@"

print_info "Updating the project with the latest changes.."

if git pull origin main; then
    if git status | grep -q "Your branch is up to date"; then
        print_success "The server is already up to date."
    else
        print_success "The server has been updated successfully."
    fi
else
    print_error "Error while updating the server. Please check the error messages above."
    exit 1
fi