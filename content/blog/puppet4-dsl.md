+++
title = "About Puppet 4.8"
lang = "en"
categories = ["Automation"]
tags = ["automation", "planet-inuits", "puppet"]
date = "2016-11-02T08:44:30"
+++

Puppet, in its new parser (long known as «future parser»), allows you to do
things like loops, lambda functions, ... And that was great. It was great
because those were things we needed. We needed that so much that the community
just went for its own variant, in ruby (`create_resources`). Being able to
remove `create_resources` is great.

However, as [Daniele stated](https://daenney.github.io/2016/10/17/goodbye-puppet.html),
Puppet has quite reached Feature Complete. That means that we made Puppet work
for all our needs. Even Puppet 3.x was feature complete. You can/could build
anything with Puppet.

Puppet, Inc. is running in all kind of directions now and they start
implementing new features everywhere. Instead of allowing us to do more and more
crazy things with the Puppet DSL, they should start wondering the question: what
is the real value for the users? It looks like the game now is to throw away as
most features as possible -- but hey, that is not what we expect from Puppet.

Puppet gets to a point when we can actually stop learning it, and focus on all
the other tasks. The job is not to automate everything nowadays -- because
everything is already automated. We want a Puppet that is transparent, fast,
silent. We want a Puppet that just works.

There are lots of bad moves in the last years. One of the latest example is the
closed source app orchestration, which breaks the spirit of Puppet to design the
final state. Strangely enough, I never needed such a thing. Instead of adapting
tools to everyone, maybe some time should be spent to explain people HOW to
design infrastructures. The fact that you need the app orchestrator maybe
means that you do something wrong.

One other bad move is the [Puppet server metrics][pem]. That was such a great
idea to expose metrics with the graphite API. Obviously, in the monitoring
world, everyone speaks graphite. The bad move was to decide that the open source
users don't deserve it. Yes, the same users that write and contribute to the
real value of Puppet, the open source modules on github and the forge.

What actually triggered that article is a [new puppet function][48], called `return`.
Let's go over a quick example:

```puppet
class bar {
  notify {'foo':}
  return()
  notify {'bar':}
}
include bar
```

And here is the result:

```text
Notice: Compiled catalog for localhost in environment production in 0.08 seconds
Notice: foo
Notice: /Stage[main]/Bar/Notify[foo]/message: defined 'message' as 'foo'
Notice: Applied catalog in 0.03 seconds
```

Great!

This is the kind of features that adds complexity for nothing. All it does is
adding complexity and making it hard to debug manifests. It is really hard to
find usecases for that `return` function. And in you have one -- you might as
well think twice.

Puppet lost is soul. When previously reading Puppet manifests was easy and
really intuitive, now you need to deal with complex functions and you barely
now what will end in the catalog at first sight.

I kinda miss my past parser.

[pem]:https://docs.puppet.com/pe/latest/puppet_server_metrics.html
[48]:https://docs.puppet.com/puppet/4.8/reference/release_notes.html
