+++
title = "puppetlabs-concat 2.0"
lang = "en"
categories = ["Automation"]
tags = ["automation", "planet-inuits", "puppet"]
slug = "puppetlabs-concat"
date = "2016-02-05T16:50:22"
+++

If you are a Puppet user, you know that you have multiple choices regarding the
way you manage your files. You might decide to manage the whole file or parts
of it. I presented that as part of my [augeas][augeas] talk at PuppetCamp London
in 2014.

One of the solutions out there is [concat][ccat]. Concats allows you to define
parts of a file as different resources, then glue them together to create a
single file.

In the past, the Puppetlabs concat module was made out of defined types, such as
it seemed very fragile or unreliable. It created temporary files, required a
setup class, and other stuff that could have been done internally in a custom
type/provider.

On the other hand, some people decided to actually write concat as a provider.
They created the Puppet module [theforeman-concat_native][ccn], which was a
really nice solution to the concat problems. From the catalog you only see the
concat resources, and not all the temporary files, directories and exec that
were needed by the Puppetlabs concat modules.

What I want to tell you today is that the Foreman module, which was really
great, is now deprecated because its changes are available in the
Puppetlabs module itself (in the 2.x releases). And it is almost compatible with
the old one, as it provides backwards-compatible defines.

What it will change for you:

* Smaller catalogs, with less hacks
* No more duplicate concat and concat_modules in your puppet trees
* Faster and easier concats
* The only change needed: depend on Concat resources and not on File resource ([like this][ex])


[augeas]:http://www.slideshare.net/roidelapluie/augeas-swiss-knife-resources-for-your-puppet-tree
[ccat]:https://github.com/puppetlabs/puppetlabs-concat
[ccn]:https://github.com/theforeman/puppet-concat_native
[ex]:https://github.com/puppetlabs/puppetlabs-apache/commit/e96a933bef3d6bdeadd78ceb2185fe6a5b3b30d5





