+++
title = "Mcollective agent to use drush"
lang = "en"
categories = ["Linux"]
tags = ["sysadmin", "drupal", "planet-inuits"]
slug = "drush-mcollective"
date = "2013-07-23T13:09:07"
aliases = ["/drush-mcollective.html"]
+++

I have written a [mcollective](https://puppetlabs.com/mcollective/) agent to run [drush](http://drush.ws) commands. It will help you to automate the deployments of your drupal websites.

I have implemented two drush commands so far:

* `cache-clear`
* `updatedb`

The full configuration is available on the [github project](https://github.com/roidelapluie/mcollective-drush).

### Examples

#### Updatedb

    ::text
    mco rpc drush updatedb root=/var/vhost/frontend-demo yes=true

#### Cache-clear

    ::text
    mco rpc drush cache-clear root=/var/vhost/frontend-demo uri=http://demo.example.net type=all

### Links

* [mcollective](https://puppetlabs.com/mcollective/)
* [drush](http://drush.ws)
* [the agent on github](https://github.com/roidelapluie/mcollective-drush)

