+++
title = "Collectd 5.4.1 RPM's"
lang = "en"
categories = ["Linux"]
tags = ["vagrant", "monitoring", "collectd", "planet-inuits"]
slug = "vagrant-collectd"
date = "2014-04-08T13:01:44"
+++

In the list of the things I like, there are [vagrant](http://vagrantup.com), RPM's
and being able to reproduce a build.

As I did two years ago with [mapnik](https://github.com/roidelapluie/vagrant-build-mapnik), I have created
a Vagrantfile with a script to build the latest version of [collectd](https://github.com/roidelapluie/collectd-rpm).
Indeed, the version of collectd available in EPEL is quite outdated. That new version
supports some very nice plugins natively, including `statsd` and `graphite` plugins.

This Vagrantfile uses the spec files that are provided [upstream](https://github.com/collectd/collectd/blob/master/contrib/redhat/collectd.spec).

After the build, a `RPMS` directory is created next to your Vagrantfile, containing
all the packages.

The project is of course [on github](https://github.com/roidelapluie/collectd-rpm).

