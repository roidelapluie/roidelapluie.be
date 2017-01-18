+++
title = "Puppet Server"
lang = "en"
categories = ["Automation"]
tags = ["centos", "automation", "planet-inuits", "puppet"]
slug = "puppet-server"
date = "2014-12-09T21:27:27"
+++

I have tested [Puppet Server](https://github.com/puppetlabs/puppet-server), the
new puppet master implementation in Clojure. And I am quite happy.

**It just works**

The first amazing thing was that it did just work the same way as Puppetmaster.

I did not need to change any configuration file. Every custom function and module just worked like before.

I am using the [puppet-puppet](https://github.com/theforeman/puppet-puppet) from [the Foreman](https://theforeman.org), which already have a `server_implementation` parameter. Switching it to `puppetserver` just did the trick.

I also needed to pass the `puppet_service_name` parameter to `puppetdb::master::config`:

```puppet
class {
  '::puppet':
    server                => true,
    server_implementation => 'puppetserver',
}

class {
  '::puppetdb::master::config':
    puppet_service_name => 'puppetserver',
}
```

**What's around also works**

Hiera was working out of the box, just like PuppetDB. Great efforts have been taken to ensure an easy transition.

There is no configuration changed needed at that level also.

**As expected, it is slow, then fast**

The startup time is really really bigger than the old `passenger+httpd` stack. It take a very long time to start.

But that was expected and once it is started it is really more efficient and catalogs get compiled in no time.

I did not experience any troubles concerning on-disk file changes. Changes to the `.pp` files were automatically picked up by the server.

**Batteries not included**

What makes me a bit sad is the fact that [Puppet Server Metrics](https://docs.puppetlabs.com/pe/latest/puppet_server_metrics.html) are completely closed source. Yes you can get a lot of these metrics by using tools like [collectd](https://collectd.org/wiki/index.php/Plugin:puppet_reports), but having the server sending them directly to a graphite server would have been very nice.

That would also have helped the community to join the Puppet Server boat. But they took their decision and there is no sign that it will change in the short time.


**I still like it**

Even if I am disappointed as a Puppet contributor to see that Puppetlabs is not open-sourcing the metrics part of Puppet Server, I still like the idea of having a good replacement for `httpd+passenger`. Playing with passenger RPM's used to be a pain in the past, and having an apache server is not ideal. With Puppet Server we have a robust daemon that is efficient.

I hope that the community will jump in to chase the bugs and write a new chapter in the Puppet story.
