+++
title = "Official CentOS boxes for CentOS"
lang = "en"
categories = ["Linux"]
tags = ["centos", "planet-inuits", "vagrant"]
slug = "vagrant-centos"
date = "2015-08-12T09:10:52"
+++

[CentOS][cos] has published [in June][mail] [Vagrant][vg] [Boxes][obox] for both Libvirt and VirtualBox provider.
I will focus on the VirtualBox one.

Those images are great for many reasons:

* They come directly from the CentOS project, so it is reasonable to trust them
* They do not come with any 3rd party repositories (and so, without Puppet/Chef...)
* They are minimal images
* They support multiple providers

They contain what is needed for basic tasks, like the vagrant user so vagrant works.

The part I appreciate the most is that they come from the project and they are very minimal. It
means that I can then install any Puppet version I want and the right VboxAdditions.

VboxAdditions are needed for vbox synced folders and internal network features.
Getting them is important to do a great job. Hopefully, vagrant is modular and
there is a plugin to install the right VboxAdditions: [vagrant-vbguest][vbg]. At the startup
of the VM, it will install the additions for you. To get it working, I needed to
add two patches to the plugin: [1][vbg1] and [2][vbg2]. They will probably be integrated
in further releases.

The other trick is with Puppet. I simply use the shell provider to get
Puppet 4 installed, as shown [here][trick].

Previously there were [a lot of boxes][box] available for CentOS. This is confusing,
and when people were making pull requests about boxes [I did not know about][pr],
my reaction was to [use a box I know][janb] from [a colleague I trust][jani].
But the fact that I trust him doesn't mean that you will. In that case an upstream
neutral box is useful.

For the moment it is only for CentOS 7. As [CentOS 7.1507 has been released][1507], we can expect
those boxes to be updated soon.


    :::bash
    vagrant init centos/7
    vagrant up


[vg]: https://www.vagrantup.com/
[cos]: http://centos.org
[mail]: http://lists.centos.org/pipermail/centos-announce/2015-June/021162.html
[box]: https://atlas.hashicorp.com/boxes/search?utf8=%E2%9C%93&sort=&provider=&q=centos
[obox]: https://atlas.hashicorp.com/centos/
[pr]: https://github.com/roidelapluie/vagrant-gerrit/pull/1/files
[janb]: https://github.com/roidelapluie/vagrant-gerrit/commit/09e1772c902681edb13a1fd87ec2e6111ac60003
[jani]: https://atlas.hashicorp.com/vStone
[trick]: https://github.com/roidelapluie/vagrant-phabricator/blob/master/Vagrantfile#L7-L14
[vbg]: https://github.com/dotless-de/vagrant-vbguest
[vbg1]: https://github.com/dotless-de/vagrant-vbguest/pull/162/commits
[vbg2]: https://github.com/dotless-de/vagrant-vbguest/pull/155/commits
[1507]: http://lists.centos.org/pipermail/centos-announce/2015-August/021307.html
