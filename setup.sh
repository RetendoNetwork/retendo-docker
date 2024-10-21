#!/usr/bin/env bash

set -euo pipefail

export RETENDO_SETUP_IN_PROGRESS=true

print_error() {
    echo -e "\e[1;31mError: ${*}\e[0m" >&2
}

if ! tput setaf 0 >/dev/null; then
    print_error "Either the tput command is not installed, or your \$TERM environment variable is not set correctly. \
Please install your distribution's ncurses package (such as ncurses-bin) and/or configure your terminal to set \$TERM."
    exit 1
fi
if ! git --version >/dev/null; then
    print_error "Git is not installed. Please install it: https://git-scm.com/downloads/"
    exit 1
fi

check_prerequisites() {
    prerequisites_failed=
    prerequisites_warning=
    if ! run_verbose docker version; then
        print_error "Docker is not installed. Please install it: https://docs.docker.com/get-docker/"
        print_info "If you see a \"Permission denied while trying to connect to the Docker daemon\" error, you need to \
add your user to the docker group: https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user."
        prerequisites_failed=true
    fi
    if ! run_verbose docker compose version; then
        print_error "Docker Compose is not installed. Please install it: https://docs.docker.com/compose/install/"
        prerequisites_failed=true
    fi
    if ! run_verbose command -v tnftp; then
        print_warning "tnftp is not installed. You will not be able to upload files to your consoles automatically."
        prerequisites_warning=true
    fi

    if [[ "$prerequisites_failed" = true ]]; then
        print_error "Prerequisites check failed. Please install the missing prerequisites and try again."
        exit 1
    elif [[ "$prerequisites_warning" = true ]]; then
        print_warning "Prerequisites check completed with warnings."

        if [[ -z "$force" ]]; then
            printf "Do you want to continue anyway (y/N)? "
            read -r continue_anyway
            if [[ "$continue_anyway" != "Y" && "$continue_anyway" != "y" ]]; then
                echo "Exiting."
                exit 1
            fi
        fi
    else
        print_success "All prerequisites are installed."
    fi
}

reconfigure=false

setup_games_env() {
    if [[ -n "$reconfigure" ]]; then
        echo "Please enter the IP address of your Retendo Network server."
        read -r server_ip
    fi

    ./scripts/setup-games-env.sh ${server_ip:+--server-ip "$server_ip"} ${force:+--force} ${reconfigure:+--no-environment}
}

# shellcheck source=./scripts/framework.sh
source "$(dirname "$(realpath "$0")")/scripts/framework.sh"
set_description "This is the setup script for your self-hosted Retendo Network server."
add_option "-f --force" "force" "Ignores warnings and confirmation prompts during the setup process."
parse_arguments "$@"

print_title "Retendo Network server setup started"

git config --local submodule.recurse true

print_stage "Checking prerequisites."
check_prerequisites

print_stage "Checking the latest update of the server."
./scripts/setup-updates.sh

print_stage "Check updates from all submodules."
./scripts/setup-submodules.sh

print_stage "Configure the games environment."
setup_games_env

# print_stage "Compiling the Innoverse-patcher."
# ./scripts/build-innoverse-patcher.sh

print_stage "Setting up all containers."
./scripts/server-containers.sh

print_stage "Building all server config."
./scripts/setup-building-config.sh

print_stage "Creating all Retendo Database."
./scripts/database/mongodb-containers.sh
./scripts/database/postgres-containers.sh

print_stage "Starting the Retendo Network server."
docker compose up -d --build

print_title "Retendo Network server setup finished"
print_success "Setup is completed !"