+++
title = "Couldn't recognize the image file format for file 'foo.png'"
lang = "en"
date = "2014-07-07T09:07:28"
+++

Solution 1
----

    gdk-pixbuf-query-loaders > /usr/lib64/gdk-pixbuf-2.0/2.10.0/loaders.cache

Solution 2
----

    update-mime-database /usr/share/mime
