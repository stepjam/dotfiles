#!/usr/bin/env bash

set -e

source "$(pwd)/scripts/util.sh"

do_install() {
    if is_installed fish; then
        info "[fish] Already installed"
        return
    fi

    info "[fish] Install"
    sudo apt install -y fish
}

do_configure() {
    info "[fish] Configure"
    info "[fish][configure] Set as default shell"
    sudo chsh -s $(which fish) $(whoami)
}

main() {
    command=$1
    case $command in
        "install")
            shift
            do_install "$@"
            ;;
        "configure")
            shift
            do_configure "$@"
            ;;
        *)
            error "$(basename "$0"): '$command' is not a valid command"
            ;;
    esac
}

main "$@"
