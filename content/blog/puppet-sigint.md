+++
title = "A fix for the Puppet Agent not exiting with SIGINT"
lang = "en"
categories = ["Automation"]
tags = ["automation", "planet-inuits", "puppet"]
slug = "puppet-sigint"
date = "2015-10-29T07:56:38"
+++

Since [Puppet][p] 3.7.5 and 4.0.0, the Puppet Agent does not exit when it receives
a SIGINT signal (^C). That is very annoying when developing Puppet modules.

A fix has been pushed yesterday by [Josh Cooper][jc] for the next 3.x and 4.x
releases. There is only one file changed, so if it's really a problem for you,
patching is trivial. Unfortunately it is not yet possible to easily rebuild
the puppet-agent RPM, but that will come very soon.

Links:

* [The patch][f], with a detailed explanation
* [Related ticket][t] in the Puppetlabs ticketing system

[p]: https://puppetlabs.com
[f]: https://github.com/puppetlabs/puppet/commit/c9a7e6d506768cb1c00767f785339bec512d069e.patch
[t]: https://tickets.puppetlabs.com/browse/PUP-4516
[jc]: https://github.com/joshcooper
