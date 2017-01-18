+++
title = 'Munin 2 "not a reference" error'
lang = "en"
categories = ["Monitoring"]
tags = ["munin", "monitoring", "planet-inuits", "puppet"]
slug = "munin2-not-a-reference-error"
date = "2014-09-02T08:49:58"
+++

This morning I worked with Munin, discovering that Munin 2 has made it to EPEL.

Thus I started to look at puppet modules. I tried two of them ([ssm-munin](https://github.com/ssm/ssm-munin) and [duritong-munin](https://github.com/duritong/puppet-munin)), and no one seemed to be working.

I was then digging deeper about what the problem could be, so I logged in to the machine with the munin user:

    ::text
    # su - munin --shell=/bin/bash

Then I ran the script by hand:

    ::
    $ test -x /usr/bin/munin-cron && /usr/bin/munin-cron
    not a reference at /usr/share/perl5/vendor_perl/Munin/Master/Utils.pm line 866

Which leaded me to [the RedHat bugzilla](https://bugzilla.redhat.com/show_bug.cgi?id=955902). But the different answers did not make me happy, even if the bug is more than one year old. Proposed solutions were doing some NSS voodoo, rebooting, restarting the node...

I then ran the script again with the --debug flag:

    ::
    $ test -x /usr/bin/munin-cron && /usr/bin/munin-cron --debug

And the error message was more clear: munin did not get any data because it could not connect to the node, because of a firewall trouble. So the "not a reference at" error just means that munin does not get any data.
