+++
date = "2017-02-09T11:33:25+01:00"
slug = "mgmt"
tags = ["cfgmgmt", "open-source", "planet-inuits"]
categories = ["Linux"]
lang = "en"
title = "mgmt"

+++

At [Config Management Camp][m], [James][j] was once again presenting [mgmt][t].
He presented the project one year ago, on his [blog][b]. There are multiple
ideas behind mgmt (as you can read on his blog):

- Parallel execution
- Event driven
- Distributed topology

And all of that makes a lot of sense. I really like it. I do really think that
this might become a huge deal in the future. But there are a couple of concerns
I would like to raise.

### It is James' project

James has been developing it since 2013. His ideas are great, however the
project is still at its very beginning, not usable yet, even for the more brave
out there. The fact that it is so early and that even early adopters have a lot
to do, makes it difficult to contribute. Even if there are 20 code contributors
to the project, James is the one that does most of the job.

I do like the fact that James knows Puppet very well. It means we speak the same
languages, he knows the problem Puppet users face, and is one of the best people
to challenge the config management community.


*How to improve that*: get involved, code, try... We need to bring this to a
more stable and usable shape before we can drag more and more contributors.

### It is scary because it is fast

With traditional configuration management, when you screw up some thing, you
still have the time to fix your configuration before it is applied everywhere.
Puppet running every 30 minutes is a good example. You have a chance to fix some
things in emergency before everyone gets them.

Even ansible is an order of magnitude slower than mgmt. And that makes it scary.

*How to improve that*: we might be able to tell mgmt to do canary releases. That
would be awesome, something really great for the future of mgmt. It is quite
hard to do so with traditional config management, but it might become native in
the future with mgmt. That would be awesome.


### It is hard to understand

mgmt internals are not as easy to understand as other tools. You can be scary at
first sight. It is using directed acyclic graphes, which enables it do do things
in parallel. Even if other config management use something close to that, in
mgmt you need to have a deep understanding of them, especially when you want to
contribute (which is the only thing you can do now). It is not hard, it is just
a price we do not have to pay with the other tools.

*How to improve that*: continue improving mgmt, remove bugs in that graph so we
are not badly affected by bugs in that graph, and we do not need to understand
everything to contribute (e.g to write new resource types or fix bugs in
resources). You can deal with Puppet, and know nothing about its internals.

### Golang is challenging

mgmt is written in go. Whether it is a great language or not is not what matters
here. What matters is that in the Ops world, go is not so popular. I am afraid
that go is not as extensible as Ruby, and the fact that you need to recompile it
to extend it is also a pain.

*How to improve that*: nothing mgmt can do. The core open-source infrastructure
tools nowadays are mainly written in go. Sysadmins need to evolve here.

### The AGPL license

I love copyleft. However, most of the world does not. This part of mgmt will be
one of the things that will slow down its adoption. Ansible is GPL-Licensed, but
the difference with Ansible and mgmt is that the last one is written in go, as a
library. You could use mgmt just as a lib, backed into other softwares. But the
licencing makes it too hard.

For a lot of other projects, the license will be the first thing they will see.
They will not ever look deeper to see if mgmt firs their needs or not.

For now I am afraid mgmt would just become a thing in the Red Hat world, where
by default lots of things are copyleft, so there would be no problem with
including mgmt.

*How to improve that*: we need to speak with the community, and decide if we
want to speed up the adoption, or to try to get more people to contribute.

### The name

Naming things is hard. But mgmt is probably not the best name. It does not sell
a dream, it does not stand out. It is impossible to do some internet searches
about it.

*How to improve that*: we need to start thinking about a better name, that would
reflect the community.

### containers

I am not sure about what will be the future of mgmt in a container world. Not
everything is moving to that world nowadays, but a lot of things actually is. I
just don't know. Need to think further about it.

## But, is there anything positive?

You can read the list above as bad things. But I see that list a my initial
ideas about how we can bring the project to the next level, how we can making it
more appealing for external contributors.

mgmt is one of the projects that I would qualify as unique and really creative.
Creativity is a gift nowadays. It is just awesome, just give it a bit more time.

We look forward to see it more stable, and to see a language that will take
advantage of it, and enable us to easily write mgmt catalogs (currently it is
all yaml). Stay tuned!


[m]:http://cfgmgmtcamp.eu/
[j]:https://ttboj.wordpress.com/
[t]:https://github.com/purpleidea/mgmt
[b]:https://ttboj.wordpress.com/2016/01/18/next-generation-configuration-mgmt/
