#!/usr/bin/env bash

set -e

source "$(pwd)/scripts/util.sh"

RVM_DIR="${HOME}/.rvm"
NVM_DIR="${HOME}/.nvm"

do_install() {
    if is_installed vim; then
        info "[vim] Already installed"
        return
    fi

    info "[vim] Install"
    #sudo add-apt-repository ppa:neovim-ppa/unstable -y
    #sudo apt update
    
    if [ "$(uname)" == "Darwin" ]; then
        brew install vim        
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        sudo apt install -y vim
    fi
}

do_configure() {
    info "[vim] Configure"
    ln -fs "$(pwd)/vim/vimrc" "${HOME}/.vimrc"
    mkdir -p "${HOME}/.vim"
    ln -fs "$(pwd)/vim/plugins.rc.vim" "${HOME}/.vim/plugins.rc.vim"
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
