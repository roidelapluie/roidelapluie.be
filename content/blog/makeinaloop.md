+++
title = "Make stuck in a loop"
lang = "en"
categories = ["Linux"]
tags = ["exherbo", "planet-inuits"]
slug = "make-in-a-loop"
date = "2014-01-20T08:44:57"
aliases = ["/make-in-a-loop.html"]
+++

I got an unexpected result when I was trying to compile a small lib: it seems to never finished (I stopped it after 3 hours).

The problem was that I had in `/usr/lib64` files timestamped in the future.

The following command fixed it and I have eventually compiled my library in 30 seconds.

    touch now
    find /usr/lib64 -newer now -exec touch ´{}´ ´;´

