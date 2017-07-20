+++
title = "Custom Sudo command with Ansible"
date = 2017-07-20T09:29:55+02:00
lang = "en"
categories = ["automation"]
tags = ["linux", "security", "ansible", "planet-inuits"]
slug = ""

+++

While introducing [Ansible](https://www.ansible.com/) at customer, I noticed the
following problem while using ansible `become` feature:

```
sudo: unable to create /var/log/sudo-io/170718-124212: File exists
sudo: error initializing I/O plugin sudoers_io
```

That was because in the sudoers configuration, you have:

```
Defaults syslog=auth,log_input,log_output,iolog_file=%y%m%d-%H%M%S
```

Which means that sudo sessions will be logged, but there can only be one sudo
session per second. While discussing with colleagues what would be the best way
to address this -- several options are possible: not logging, logging with seq
(`Defaults:ansible iolog_file=ansible/%{seq}`), logging microseconds, ... -- I
have implemented a workaround.

What is interesting is that it uses an undocumented feature: `become_exe`.

I dropped a file in the ansible repo with the following content:

```
[privilege_escalation]
become_exe = /bin/sleep 1 && /bin/sudo
```

And, magically, ansible now waits one second between sudo commands. Enough to
let me continue working while looking for the best resolution.
