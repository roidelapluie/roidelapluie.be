+++
title = "Pacemaker and corosync"
lang = "en"
date = "2013-12-18T10:19:20"
+++

If you get the following:

    [root@devvm ~]# crm configure load update crm-resource.txt
    error: unpack_resources:	Resource start-up disabled since no STONITH resources have been defined
    error: unpack_resources:	Either configure some or disable STONITH with the stonith-enabled option
    error: unpack_resources:	NOTE: Clusters with shared data need STONITH to ensure data integrity
    Errors found during check: config not valid
    Do you still want to commit?

you can fix it like this:

    pcs property set stonith-enabled=false

it is okay to develop a cluster
