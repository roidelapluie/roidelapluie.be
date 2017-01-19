+++
title = "Archlinux on a Raspberry pi"
lang = "en"
date = "2013-12-16T08:57:43"
+++

install a package

    pacman -S screen

remove a package

    pacman -R screen

default shell is bash

shipped with vi (not vim)

    pacman -S vim

root ssh login is enabled; change password, add new user, create his home

virtualenv

    pacman -S python2{,-virtualenv}
