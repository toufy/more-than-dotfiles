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
        echo -e '\033[01;32m:)\033[0m'
    else
        echo -e '\033[01;31mx(\033[0m'
    fi
}

### ---prompt--- ###
PS1='$(excode) \u@\H\[\e[36m\]::\[\e[4;37m\]\w\[\e[0m\]\n\[\e[36m\]$\[\e[0m\] '

### ---direnv--- ###
if command -v direnv >/dev/null 2>&1; then
	eval "$(direnv hook bash)"
fi
