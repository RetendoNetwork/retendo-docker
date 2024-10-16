#!/usr/bin/env bash

# shellcheck source=./framework.sh
source "$(dirname "$(realpath "$0")")/framework.sh"
set_description "This configures, resets the contents of, and applies patches to the submodules in the repos directory."
add_option "-u --update-remote" "update_remote" "Updates the submodules from their remotes before applying patches. Only \
use this if you're trying to update the submodules to a newer version than is supported by this project. If a patch \
fails to apply, a 3-way merge will be attempted."
parse_arguments "$@"

print_info "Resetting all submodules..."

GITMODULES_PATH="$git_base_dir/.gitmodules"
REPOS_PATH="$git_base_dir/repos"

if [ ! -f "$GITMODULES_PATH" ]; then
    exit 1
fi

mkdir -p "$REPOS_PATH"

git submodule update --init --recursive

for submodule in $(git config --file "$GITMODULES_PATH" --get-regexp path | awk '{ print $2 }'); do
    mv "$submodule" "$REPOS_PATH/"
done

echo "Tous les sous-modules ont été déplacés dans le dossier repos."