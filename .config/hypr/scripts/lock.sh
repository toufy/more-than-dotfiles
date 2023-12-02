#!/bin/bash

grim "$HOME"/tmp/.lockbg &&
    convert -filter Gaussian -blur 0x5 "$HOME"/tmp/.lockbg "$HOME"/tmp/.lockbg &&
    swaylock
