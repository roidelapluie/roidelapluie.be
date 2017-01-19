+++
title = "Fixing a GlusterFS split-brain"
lang = "en"
categories = ["Linux"]
tags = ["GlusterFS", "planet-inuits"]
slug = "glusterfs-split-brain"
date = "2013-07-17T16:27:17"
aliases = ["/glusterfs-split-brain.html"]
+++

I have found some time to test [GlusterFS](http://gluster.org), in order to use it to replicate data between several servers.

I have created two [vagrant](http://vagrantup.com) boxes to set up a basic cluster.

And, during my tests, I have shut down the network interfaces and started writing different things on the same file, to create a [split-brain](http://en.wikipedia.org/wiki/Split-brain_%28computing%29).

    :::bash
    srv01$ echo good > /mnt/test
    srv02$ echo bad > /mnt/test

When the interfaces were up again, the split-brain was obviously present:

    :::bash
    srv02$ cat /mnt/test
    cat: /mnt/test: Input/output error

In the logs, I have found the following sentence:

    :::Text
    [2013-07-17 13:57:54.156318] E [afr-self-heal-common.c:197:afr_sh_print_split_brain_log]
    0-gv0-replicate-0: Unable to self-heal contents of '<gfid:470a742c-b0d6-4846-9ab3-2483c3a0c8da>'
    (possible split-brain). Please delete the file from all but the preferred subvolume.-
    Pending matrix:  [ [ 0 1 ] [ 1 0 ] ]

So I tried to delete the file in the node that was "wrong" to me:

    :::bash
    srv02$ cat /export/brick1/sdb1/test
    srv02$ sudo rm /export/brick1/sdb1/test

But it was obviously not working:

    :::bash
    srv02$ cat /mnt/test
    cat: /mnt/test: Input/output error

Even more, the file `/export/brick1/sdb1/test` was recreated by Gluster!

    :::bash
    srv02$ cat /export/brick1/sdb1/test
    wrong

The solution was the following: Gluster is creating hard links in a .gluster directory, and you have to delete all the hard links to the file to get rid of it.
Please note that I am working on the 'brick'.

    :::bash
    srv02$ sudo find /export/brick1/sdb1/ -samefile /export/brick1/sdb1/test -print -delete
    /export/brick1/sdb1/.glusterfs/47/0a/470a742c-b0d6-4846-9ab3-2483c3a0c8da
    /export/brick1/sdb1/test

And it worked!

    :::bash
    srv02$ cat /mnt/test
    good
    srv02$ cat /export/brick1/sdb1/test
    good

### Additional notes

Only the files that were "brain-splitted" were unreadable.

You can have the list of these files by running the following command:

    :::bash
    $ gluster volume heal gv0 info
    Brick 192.168.1.10:/export/brick1/sdb1
    Number of entries: 1
    /test

    Brick 192.168.1.11:/export/brick1/sdb1
    Number of entries: 1
    /test

To avoid split-brains, you can enable [quorums](http://www.gluster.org/community/documentation/index.php/Features/Server-quorum).

### Links

* [GlusterFS](http://gluster.org)
* The [quickstart](http://www.gluster.org/community/documentation/index.php/QuickStart) that I have used.
* Explanation of GlusterFS-related [terms](http://www.gluster.org/community/documentation/index.php/GlusterFS_Concepts)
