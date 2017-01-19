+++
title = "Soft-fixing Lenovo touchpad"
lang = "en"
categories = ["Linux"]
tags = ["hardware", "planet-inuits"]
slug = "lenovo-touchpad"
date = "2014-01-22T07:38:18"
aliases = ["/lenovo-touchpad.html"]
+++

I have a new lenovo laptop but it has no physical button (the whole touchpad is
a button). It is almost impossible to right click and impossible to
middle-click, which is critical for me.

I solved this with the following `synclient` options:


    :::bash
    synclient TapButton1=1
    synclient TapButton2=2
    synclient TapButton3=3

When I click the touch pad with one finger, it will left-click, two will
middle-click and three will left-click.
