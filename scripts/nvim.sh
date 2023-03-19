#!/usr/bin/env bash

set -e

source "$(pwd)/scripts/util.sh"

NVIM_VERSION="v0.8.3"

do_install() {
    if is_installed nvim; then
        info "[nvim] Already installed"
        return
    fi

    info "[nvim] Install"
    
    if [ "$(uname)" == "Darwin" ]; then
        brew install neovim        
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        local neovim=/tmp/neovim.deb
        download_to "${neovim}" "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux64.deb"
        sudo dpkg -i "${neovim}"
    fi
}

do_configure() {
    info "[nvim] Configure"
    ln -fs "$(pwd)/nvim" "${HOME}/.config"
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
