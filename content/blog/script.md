+++
title = "Script, a must-know command for sysadmins"
lang = "en"
categories = ["Linux"]
tags = ["sysadmin", "planet-inuits"]
slug = "script"
date = "2015-07-04T12:04:14"
+++

`script` is a famous command in the unix world. Part of the [util-linux](https://www.kernel.org/pub/linux/utils/util-linux/)
package of Linux distros, and so available almost everywhere, it has some very interesting features.

## Recording a shell session

This is the primary usage. Just type:

    script output.txt

A new shell will open, and you can just do whatever you want.

    $ script output.txt
    Script started, file is output.txt
    $ echo hello world
    hello world
    $ exit
    Script done, file is output.txt


Once you have
finished, you close the shell (`exit` or `^D`) and then you can replay your session
with `cat`:


    $ cat output.txt
    Script started on Sat 04 Jul 2015 11:15:15 AM CEST
    $ echo hello world
    hello world
    $ exit

    Script done on Sat 04 Jul 2015 11:15:21 AM CEST

It also records what you type, your bash PS1 etc...

But that would replay everything at once. You can improve that by recording with
timing (`-t`). Timing information is sent do stderr.

    script -t output.txt 2>output.txt.timing

You can then replay easily with:

    scriptreplay output.txt.timing output.txt

`scriptreplay` has a lot of interesting options, like `--divisor` and
`--maxdelay`.

## Real-time terminal sharing

It is also possible to stream what you are doing. To do so, you can use a named pipe.

    mkfifo /tmp/mystream
    script -f /tmp/mystream

The `-f` option means 'flush at every write'.

On the other hand, the person that wants to see what you are doing just has to run:

    cat /tmp/mystream

Now you will see the same things.

You can do the same with `screen`, except that `screen` is not installed everywhere
and you can not have a `screen` read-only.

## Own your tty

This is the last use case I have with `script` and it useful as well. In some situations,
you have to 'own' your own tty.

Examples of such situations include `screen` and `sudo` commands.

    # su - roidelapluie
    $ screen
    Cannot open your terminal '/dev/pts/38' - please check.

In that case, script can help you:

    # su - roidelapluie
    $ script /dev/null
    Script started, file is /dev/null
    $ screen

It also works to run `sudo` when you forget to use `ssh -t`.

You can also run a command directly with `-c`. In that case do not forget to add
`-e` if you are interested by the exit code of the command you launch.

    script -c mycommand -e

## Conclusion

`script` is a nice command that can be useful in several situations, and it has
the advantage to be present almost everywhere.
