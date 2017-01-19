+++
title = "Usefull strace commands"
lang = "en"
date = "2013-12-16T08:57:43"
+++

open-close
---

Strace only open and close file of a launched process (useful to check if a rsync is doing something for example)

    strace -p 26428 -e trace=open,close

where 26428 is the PID


