#!/bin/bash

### ---source stuff--- ###
# global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi
# aliases
source "$HOME"/.bash/aliases.sh

### ---custom functions--- ###
# check exit code of previous command
excode() {
    if [[ $? == 0 ]]; then
        printf '\033[01;32m:)\033[0m'
    else
        printf '\033[01;31mx(\033[0m'
    fi
}

### ---prompt--- ###
PS1='$(excode) \u@\H:\[\e[4;32m\]\w\[\e[0m\]$ '
