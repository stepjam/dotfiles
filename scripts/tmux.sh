#!/usr/bin/env bash

set -e

source "$(pwd)/scripts/util.sh"

do_install() {
    if is_installed tmux; then
        info "[tmux] Already installed"
        return
    fi

    info "[tmux] Install"

    if [ "$(uname)" == "Darwin" ]; then
        brew install tmux        
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        sudo apt install -y tmux
    fi
}

do_configure() {
    info "[tmux] Configure"
    info "[tmux][configure] Download tpm plugin manager"
    if [[ ! -d "${HOME}/.tmux/plugins/tpm" ]]; then
        git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
    fi

    info "[tmux][configure] Create symlinks"
    ln -fs "$(pwd)/tmux/tmux.conf" "${HOME}/.tmux.conf"
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
