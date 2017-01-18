+++
title = "A Puppet module for Puppet 4"
lang = "en"
categories = ["Automation"]
tags = ["automation", "planet-inuits", "puppet"]
slug = "puppet-puppet-4"
date = "2015-07-26T22:05:50"
+++

I have been working today on a [pull request][pr1] for the [puppet-puppet][repo]
module. That module, part of the foreman puppet modules suite, is probably the
most used in its category.

The pull request I've been working on is about support of the new ['All In One'][aio]
package and Puppet 4. It will probably be merged very soon.

An important part of the work was done by [Mickaël Canévet][mca], from [camptocamp][c2c].
I did polish it a bit, rebase it and make the tests pass.

With our combined work, you can now use the great puppet-puppet module to deploy
a puppet stack with AIO packages, and start testing the new Puppet 4 features right now!


[pr1]: https://github.com/theforeman/puppet-puppet/pull/290
[repo]: https://github.com/theforeman/puppet-puppet/
[aio]: https://puppetlabs.com/blog/say-hello-open-source-puppet-4
[mca]: https://github.com/mcanevet
[c2c]: http://camptocamp.com
