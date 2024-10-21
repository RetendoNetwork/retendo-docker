#!/usr/bin/env bash

# shellcheck source=./framework.sh
source "$(dirname "$(realpath "$0")")/framework.sh"
set_description "This file is for build the Innoverse-patcher Wii U."
parse_arguments "$@"

print_info "Compiling the Innoverse-patcher patches.."
./../repos/Innoverse-patcher/build.sh