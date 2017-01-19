+++
title = "Yum could'n connect to host"
lang = "en"
date = "2015-01-16T10:50:50"
+++

The following error is not always what it looks like:


    ::text
    $ yum search glib
    Plugin "product-id" can't be imported
    Plugin "subscription-manager" can't be imported
    Loaded plugins: refresh-packagekit, security
    http://repo.inuits.eu/myrepo/repodata/repomd.xml: [Errno 14] PYCURL ERROR 7 - "couldn't connect to host"
    Trying other mirror.
    Error: Cannot retrieve repository metadata (repomd.xml) for repository: repo. Please verify its path and try again

In this case I was running `yum` without being root.
