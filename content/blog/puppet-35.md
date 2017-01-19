+++
title = "CentOS users should skip puppet release 3.5.0"
lang = "en"
categories = ["Automation"]
tags = ["centos", "automation", "planet-inuits", "puppet"]
slug = "puppet-350-yumrepo"
date = "2014-04-11T09:51:14"
aliases = ["/puppet-350-yumrepo.html"]
+++

Dear puppet users using a yum-based distribution, if you use the Yumrepo resource type,
don't upgrade to [puppet 3.5.0](http://docs.puppetlabs.com/puppet/3.5/reference/release_notes.html). That resource
type has been rewritten and the release has come with very annoying bugs.

### Bugs

* [PUP-2163: yumrepo resource completely broken](https://tickets.puppetlabs.com/browse/PUP-2163)
* [PUP-2150: yumrepo removable URL properties cannot be set to ‘absent’](https://tickets.puppetlabs.com/browse/PUP-2150)
* [PUP-2179: Ensuring absent on a yumrepo removes all repos in the same file](https://tickets.puppetlabs.com/browse/PUP-2179)
* [PUP-2178: yumrepo ‘descr’ property doesn’t map to the ‘name’ INI property](https://tickets.puppetlabs.com/browse/PUP-2178)
* [PUP-2181: Setting yumrepo string properties to absent assigns the literal ‘absent’ string](https://tickets.puppetlabs.com/browse/PUP-2181)

### Fixes

Fixes have been merged to master and will be released with Puppet 3.5.1. Considering
the impact of the bugs, we can expect that to arrive very soon.

---

**Update (19 May 2014)**: [Puppet 3.5.1](http://docs.puppetlabs.com/puppet/3.5/reference/release_notes.html) solved most of these problems, and [puppet 3.6.0](http://docs.puppetlabs.com/puppet/3.6/reference/release_notes.html) fixed the
remaining ones.
