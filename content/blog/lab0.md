+++
title = "lab0, a light frontend to foreman"
lang = "en"
categories = ["Automation"]
tags = ["foreman", "puppet", "automation", "planet-inuits"]
slug = "lab0"
date = "2014-03-14T08:50:37"
aliases = ["/lab0.html"]
+++

I have written a small frontend to [Foreman](http://theforeman.org) and its [Puppet](https://puppetlabs.com/puppet/puppet-open-source) integration.

The only goal is to provide our developers to change the puppet parameters of their
hosts in an easy way, and to rebuild the nodes in a few clicks.

The project consists is presented as a single web page, where you make changes. Angularjs makes that page reactive.

It requires admin rights on foreman (it uses the API). When a user is connected, he
can change the parameters that you have pre-defined in a configuration file.

You can have explicit labels for your parameters, making it easy to understand what is going on.

You can also change the host groups of the vms (once more, the list of available hostgroups is
pre-defined).

I hope you will enjoy it. You can find a screenshot on the github page. There is also a demo of the
web frontend.

### Technologies

#### Backend

* Django
* Django-tastypie
* Python-requests

#### Frontend

* AngularJS
* Bootstrap


### Links

* [lab0 on github](https://github.com/roidelapluie/lab0)
* [demo](http://lab0.roidelapluie.be)

