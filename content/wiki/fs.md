+++
title = "Finding the filesystem of a partition"
lang = "en"
date = "2013-12-16T08:57:43"
+++

    file -sL /dev/sda3
    fsck -N /dev/sda3
