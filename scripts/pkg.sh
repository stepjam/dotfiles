#!/usr/bin/env bash

set -e

source "$(pwd)/scripts/util.sh"

DEBIAN_FRONTEND=noninteractive

do_install() {
    local shared_packages=(
        git
        curl
        htop
        python3
        tree
        unzip
        wget
        xclip
    )

    info "[pkg] Install"
    if [ "$(uname)" == "Darwin" ]; then
        local mac_packages=(
            bash
        )
        brew update
        brew upgrade
        brew install "${shared_packages[@]}"        
        brew install "${mac_packages[@]}"        
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        local linux_packages=(
            build-essential
            cmake
            python3-pip
        )
        sudo apt update
        sudo apt-get install -y "${shared_packages[@]}"
        sudo apt-get install -y "${linux_packages[@]}"
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
