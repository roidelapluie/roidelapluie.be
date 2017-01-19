+++
title = "Peering a server to a GlusterFS cluster"
lang = "en"
categories = ["Linux"]
tags = ["GlusterFS", "planet-inuits"]
slug = "peering-a-server-to-a-glusterfs-cluster"
date = "2013-07-18T13:46:57"
aliases = ["/peering-a-server-to-a-glusterfs-cluster.html"]
+++

Some notes about how to add server to a [GlusterFS](http://gluster.org) cluster and to replicata data to it.

    ::bash
    srv03$ sudo gluster peer probe 192.168.1.10
    peer probe: failed: 192.168.1.10 is already part of another cluster

It is logical that anyone may not add a server to a gluster cluster.

    ::bash
    srv01$ sudo gluster peer probe 192.168.1.12
    peer probe: success

It is successful.

    ::bash
    srv01$ sudo gluster peer status
    Number of Peers: 2

    Hostname: 192.168.1.10
    Uuid: 99f74112-cca9-439e-802e-a7822da446c9
    State: Peer in Cluster (Connected)

    Hostname: 192.168.1.12
    Port: 24007
    Uuid: 9099c59c-a667-4bb4-b5ea-fb6bc08e1e9a
    State: Peer in Cluster (Connected)

And, first try to add the new node to the cluster will be a failure:

    srv02$ sudo gluster volume add-brick gv0 192.168.1.12:/export/brick1/sdb1
    volume add-brick: failed: Incorrect number of bricks supplied 1 with count 2

When I created the volume, I set the replica value to 2, so I guess Gluster wants me to add "bricks" two by two. Instead, I am going to update the replica value.

    srv02$ sudo gluster volume add-brick gv0 replica 3 192.168.1.12:/export/brick1/sdb1
    volume add-brick: success

Are the file replicated on the third node? Not yet.

    srv03$ ls /export/brick1/sdb1/ | wc -l
    0

But, the first time I list the files in the **mounted** volume, the files are replicated:

    srv01$ ls /mnt|wc -l
    125

    srv03$ ls /export/brick1/sdb1/ | wc -l
    125

And I am done.
