+++
title = "Vagrant will support VirtualBox linked clones"
lang = "en"
categories = ["Linux"]
tags = ["vagrant", "virtualbox", "planet-inuits"]
slug = "vagrant-will-support-vbox-clones"
date = "2015-06-05T08:40:59"
+++

Here is a good news for the [vagrant](http://vagrantup.com) users that still use VirtualBox.
While vagrant has support for many other providers, I guess that VirtualBox is probably still
in the top 3.

A September 2014 [Pull Request](https://github.com/mitchellh/vagrant/pull/4484) by [mpoeter](https://github.com/mpoeter) has been updated some days ago. That
pull request is about the support of a long-existing VirtualBox feature, linked clones.
And it will more than probably be integrated in the next release.

Linked clones are just like Clones, except that the disks are linked to the "master"
disks, and the data are written incrementally on another disk. It means that the initial import
of the Vagrant boxes will be instant, even if your laptop has non-ssd disks.

The initial import of the VirtualBox boxes was one of the bottlenecks of this plugin,
and a disadvantage compared to those based on LXC, KVM or docker.
