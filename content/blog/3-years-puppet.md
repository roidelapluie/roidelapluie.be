+++
title = "3 years of automation with Puppet"
lang = "en"
categories = ["Automation"]
tags = ["centos", "automation", "planet-inuits", "puppet"]
slug = "3-years-of-puppet"
date = "2014-11-17T22:24:13"
+++

*This article has been triggered by [M@ttias.be's article](http://ma.ttias.be/3-years-puppet-config-management-lessons-learned/).*

I have been working for Inuits for 3 years, with Puppet 2.6. By that time
Puppet 0.23 was still around in many places. Here are some lessons I've learned during these years.


## Your Puppet code is code

This is one of the first lessons I've learned. In the many environments I've seen, some of
them use some git hooks/rsync/whatever to deploy the puppet code to the different
platforms. This never works. There are always problems, because human beings make mistakes and CI testing matters.

Working with multiple environment is important (dev, uat, prod...), and running tests on your puppet tree
is also important.


## Puppet is even more important if you do not touch an infrastructure often

When you need to provide support for an infrastructure, when what you have to do is
only unplanned intervention (aka firefighting), it is really important that anything that has changed
in this infra is in the puppet tree.

Having a good puppet tree in git shows you what has changed, when and why. Good commit
messages also matter a lot.

When I log in only once a month on a platform, I want to know what have the other people done.
By doing that I don't get bad surprises and I can work more quickly and better.

On the opposite, every time the gap between the puppet code and the reality is growing,
my future work is slowed down.


## You should never disable puppet on a node

Disabling puppet on a node is just good to never get that node updated again.
It is so easy when you have dozens of server to forgot about one server that will
get out of sync quickly.

What can you do then? You have several approaches. I generally prefer to set noop mode
instead of completely disabling an agent. But another option is to prevent puppet
to change the system, like doing a `chattr +i` on a file you do not want puppet to
change.

This will show you perpetual errors in your dashboard, reminding you what you have to fix. Because, you have a dashboard, haven't you?


## You need a puppet dashboard

Puppet apply is often a no-go because you will use it once and then forget. So you will get a puppetmaster and puppetdb. There are
a few dashboards available, but my preferred one is The foreman.

A dashboard gives you interesting metrics and a good overview of your infrastructure.
If you don't have one you are just missing a lot of interesting data.


## Puppet has bugs, don't update too quickly

Puppet has bugs. New releases also. So do not use Puppetlabs upstream. Test the
new packages on some servers and see what needs to be changed.

Sometimes Puppet introduces a lot of new warning messages, sometimes they rewrite
a native provider... All these stuff can contain errors and be very annoying.


## The community is great

Puppet has a large community. On freenode, twitter, github, there are a lot of people
ready to discuss and to help. People are contributing back on the projects and the
modules.

People go to PuppetCamp, PuppetConf, and other configmgmt and open-source conferences.
Just meet them, they have a lot of ideas. There are also a lot of beginners to help.
Puppet is not an easy tool and it is getting more complex over time.


## It is hard to fix a puppet tree

Being early Puppet users has downsides. For example when you have your
whole infrastructure with passwords in modules, and a lot of other things that are no longer
best practices nowadays. But 3 years ago that was still acceptable.

It is hard to see what would be the benefits of a rewrite of the code... Which
brings us to the next lesson:


## Automation != you're doing it right

Using Puppet does not mean your infrastructure is managed correctly. You need to
ask yourself the right questions, because automation is not a goal. Automation brings
you a lot of different tools, an overview of your infra, but it will not erase your
technical debt. It can even be the opposite.

You need to combine puppet with other tools, update your servers, your puppet setup,
your puppet modules, to go ahead and be in a process of continuous improvement.
That process is important if you want to always deliver a good quality infrastructure.


## Your puppet master needs to be highly available

... or you need to be able to rebuild it quickly.

Like the monitoring system, the automation system should be more available than the
product. Because we have so complex infrastructure nowadays than you have to be able
to deliver a new server and to modify that infrastructure at any moment. When PM
is not available, you are blocking any improvement of your infrastructure.


## I don't need Puppet because I only have one server

That is completely false. A lot of people think that puppet is for large scale.
But if you only have one or 2 servers, you probably wish to be able to rebuild
them quickly. And at that moment you'll be happy to have made the effort of puppetizing it.


## Puppet is difficult. More than other tools?

Managing an infrastructure is difficult. If you can not make the effort of learning
a technology like Puppet, then are you really working in IT? Puppet/Chef and other
tools bring a real added value and will really save you time and money. This
is not an excuse to learn too much because of the following lesson:


## If it is too complicated, it is a design problem

If you need to write a lot of custom functions and facts then you are probably
abusing Puppet. More than ever we need to keep the things as simple as possible.
Think twice before writing a custom function. And if you really need one, write tests.

If Puppet is so complex that you need to know everything about ruby then look at
how other people are doing to keep nice and clean puppet trees.


## The unix philosophy applies to puppet modules

Yes, you need to have modules that do one thing but that do it well. It is then easy
to just update one component without affecting the others. Everything like sysctl config,
vhosts, and other "generic" services should not be grouped together. One module for one
service/tool.


## Conclusion

I have found out more other lessons during these 3 years, and the incoming changes in
puppet will certainly show me more of them.

Be sure to also look at this [slidedeck from Kris Buytaert about 7 Puppet Horror Stories](http://www.slideshare.net/KrisBuytaert/7-years-of-puppet-horror-stories) and the lessons learned of [Mattias](http://ma.ttias.be/3-years-puppet-config-management-lessons-learned/).
