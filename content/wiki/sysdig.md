+++
title = "Sysdig"
lang = "en"
date = "2014-05-26T20:59:03"
+++

[Sysdig](http://www.sysdig.org/) is an open-source app that "straces" all the system.



can be downloaded here http://pkgs.org/download/sysdig

does not need epel

usage:

listing helpers script

    sysdig -cl


writing to a file

    sysdig -w sysdig.tr # writing to a file


filtring by pid

    sysdig -r sysdig.tr pid = 5000


filtering my filename

    sysdig fd.dilename=puppet.conf


## Extra

Mattias has written a [blog post](http://mattiasgeniar.be/2014/10/03/sysdig-cli-examples/) with more examples (october 2014).
