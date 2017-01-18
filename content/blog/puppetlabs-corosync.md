+++
title = "Puppet-corosync and pcs provider"
lang = "en"
categories = ["Automation"]
tags = ["high availability", "linux", "planet-inuits"]
slug = "puppet-corosync-pcs"
date = "2014-01-28T20:40:19"
+++

Since the release 6.4, el-based distributions are not shipped with the `crm` command
by default. [`pcs`](http://github.com/feist/pcs) is the new [recommended way](http://blog.clusterlabs.org/blog/2013/pacemaker-on-rhel6-dot-4/) to [setup the clusters](http://blog.clusterlabs.org/blog/2012/pacemaker-and-cluster-filesystems/) on CentOS/RHEL >= 6.4.

A lot of the people using the [puppetlabs-corosync](http://github.com/puppetlabs/puppetlabs-corosync) module
have been surprised and they just installed a RPM found somewhere across the web.

I adapted the puppetlabs-corosync to end that dependency. My puppetlabs-corosync
module is [available here](http://github.com/roidelapluie/puppetlabs-corosync).

It is not perfect, but I still plan on working on it in the following months (and
I accept pull requests of course). Any feedback is welcome.

I only use the providers of that module. Everything under the manifests directory
is deprecated. Besides that, I use a `puppet-cman` and a `puppet-pacemaker` module,
designed to be published soon, that manage the installation of the cluster
service.

