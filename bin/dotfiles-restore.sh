#!/usr/bin/env bash

set -xe

# arg check
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <remote repository>"
fi

DF_PATH=$HOME/.dotfiles
alias dotfiles='git --git-dir=$DF_PATH --work-tree=$HOME'

git clone -b main --bare $1 $DF_PATH
        
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout || echo "Move or delete conflicting files first, then run 'dotfiles checkout' to finish restore."