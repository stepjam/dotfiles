#!/usr/bin/env bash

set -e

source "$(pwd)/scripts/util.sh"

do_install() {
    if is_installed exa; then
        info "[exa] Already installed"
        return
    fi

    info "[exa] Install"
    
    if [ "$(uname)" == "Darwin" ]; then
        brew install exa        
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        TMPDIR=$(mktemp -d)
        cd $TMPDIR
        curl -L -O https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
        unzip exa-linux-x86_64-0.9.0.zip
        mkdir -p $HOME/.local/bin
        mv exa-linux-x86_64 $HOME/.local/bin/exa
        rm -rf $TMPDIR
    fi
}

main() {
    command=$1
    case $command in
        "install")
            shift
            do_install "$@"
            ;;
        *)
            error "$(basename "$0"): '$command' is not a valid command"
            ;;
    esac
}

main "$@"
