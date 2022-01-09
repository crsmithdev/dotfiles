#!/usr/bin/env bash

set -xe

DF_PATH=$HOME/.dotfiles
alias dotfiles='git --git-dir=$DF_PATH --work-tree=$HOME'

git clone -b main --bare git@github.com:crsmithdev/dotfiles $DF_PATH
        
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout || echo "Move or delete conflicting files first, then run 'dotfiles checkout' to finish restore."
