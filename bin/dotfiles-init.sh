#!/usr/bin/env bash

set -xe

DF_PATH=$HOME/.dotfiles
alias dotfiles='git --git-dir=$DF_PATH --work-tree=$HOME'

git init --bare $DF_PATH
dotfiles commit --allow-empty -m "initial commit"
dotfiles config --local status.showUntrackedFiles no
dotfiles branch -m main
