+++
title = "Foreman could get Puppet 4 support sooner than expected"
lang = "en"
categories = ["Automation"]
tags = ["foreman", "puppet", "automation", "planet-inuits"]
slug = "foreman-puppet-4"
date = "2015-10-03T14:25:37"
+++

[Foreman][f] is one of the key tools of many [puppet][p]-based infrastructures.
It can interact with the Puppet stack in different ways, by acting as a reporting
dashboard or a complete ENC.

So far Foreman only supports up to Puppet 3. Puppet 4 brings in many changes, and
that involves [a lot of changes][rm] in the foreman side. Even the foreman-installer is [based on Puppet][kafo].

But slowly, Puppet 4 supports starts to come to reality. The [puppet module][pm] to
install and manage Puppet now supports Puppet 4.

But another great achievement is that the next major version of [foreman smart-proxy][fp]
will contain Puppet 4 support, thanks to 2 [pull][pr1] [request][pr] (special thanks
[Damien Churchill][dc] and [Dmitri Dolguikh][dd]).

It means that it could be able to test a Puppet 4 smart proxy for the foreman
in the next release. It will probably get then one extra major release to get something
more production-ready (understand: that will have been more tested). And there
are still other [problems][pro] related to the new Puppet AIO package to fix first.

Puppet 4 is slowly coming to the community and Foreman,
which is great. We need Open-Source applications like the Foreman more than ever
because Puppetlabs is pushing more and more closed-source puppet dashboards
and 'applications'.

[f]: http://theforeman.org
[fp]: https://github.com/theforeman/smart-proxy
[p]: https://github.com/puppetlabs/puppet
[pm]: https://github.com/theforeman/puppet-puppet
[pr]: https://github.com/theforeman/smart-proxy/pull/317
[pr1]: https://github.com/theforeman/smart-proxy/pull/313
[dc]: https://github.com/damoxc
[dd]: https://github.com/witlessbird
[rm]: http://projects.theforeman.org/issues/8447
[kafo]: https://github.com/theforeman/kafo
[pro]: http://projects.theforeman.org/issues/11992
