+++
title = "Fill your Belgian tax form with Linux"
lang = "en"
categories = ["Linux"]
tags = ["belgium", "planet-inuits"]
slug = "tax-on-web"
date = "2013-07-15T21:52:50"
aliases = ["/tax-on-web.html"]
+++

Tax-on-web is the online service that enable you to fill in your Belgian tax form.

In order to be able to read you beid card, and so to connect to the online website, follow the following instructions.

First, get a card reader, and install the relevant driver. The following will often be enough (if you are using debian/ubuntu):

    $ sudo apt-get install libacr38u pcscd

Then, *do not* install the [software provided by the government](http://code.google.com/p/eid-mw/).

Instead, install opensc.

    $ sudo apt-get install opensc

Open Firefox, and go to `Edit` > `Preferences` > `Certificates` > `Security devices`.

Click on `Load` then enter "Beid" as module name (it does not matter), and put `/usr/lib/opensc-pkcs11.so` as second field. You might need to select it with the `Browse button`. If the file does not exist, try `/usr/lib64/opensc-pkcs11.so`.

You might need to start openscd:

    $ sudo service openscd start

Restart Firefox, and go to [tax-on-web](http://taxonweb.be).

You are done.
