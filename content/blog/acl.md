+++
title = "Access Control Lists: the hidden feature of EL7"
lang = "en"
categories = ["Linux"]
tags = ["centos", "planet-inuits"]
slug = "acl-el7"
date = "2015-08-14T08:36:54"
+++

[CentOS][cos] 7 and its upstream, [RHEL7][el7], come by default with the XFS filesystem.

As it looks like it will not change a lot in our everyday sysadmin lifes, this is
not strictly true. There is a big side effect of this change: by default, ACL are enabled
in that filesystem.

It means that without changing the fstab, you can now give additional rights to
files and directories. You can find a lot of [guides](http://linux-training.be/storage/ch03.html) about how
to use them everywhere on the internet.

It would also allow an attacker to discretely open more rights to a directory; it
can bring a lot of unneeded complexity if used by unskilled sysadmins.

In EL6 you can already do this but by default you need to add the `acl`
option to the fstab because the default filesystem is EXT4.

Of course, if you do not want them, you can chose to add `noacl` to the fstab options and
remount the filesystems (`mount -o remount,noacl /`). I would recommend this if you
do not need them.

[cos]: http://centos.org
[el7]: https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/
