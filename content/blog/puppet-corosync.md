+++
title = "Pcs support merged into puppetlabs-corosync"
lang = "en"
categories = ["Automation"]
tags = ["centos", "automation", "HA", "planet-inuits", "puppet"]
slug = "puppetlabs-corosync-pcs"
date = "2014-07-02T08:32:42"
+++

Great news for people using an el-based distribution and the [puppetlabs-corosync](https://github.com/puppetlabs/puppetlabs-corosync)
puppet module: [pcs support has been merged into master](https://github.com/puppetlabs/puppetlabs-corosync/pull/64).

This change is important because it means that all the RPM required for these providers are in the main repositories, which ensure they are tested and supported.

Starting from CentOS 6.4, the `crm` shell was not provided by Red Hat anymore, but the puppet module was using that package in its only provider for custom types. Downloading a RPM from a Suse developer's personal web space was needed.

My work is based on previous work done by [Joshua Hoblitt](https://github.com/jhoblitt). It keeps `crmsh` compatibility, useful for CentOS < 6.4 users, which means there is now two providers in the module.

Please test & send feedback about that merge.
