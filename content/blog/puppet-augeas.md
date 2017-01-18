+++
title = "Speed up Puppet and Augeas"
lang = "en"
categories = ["Automation"]
tags = ["automation", "planet-inuits", "puppet"]
slug = "speed-up-puppet-augeas"
date = "2015-08-19T12:06:35"
+++

Here is a tip for those using the Puppet 'augeas' native resource: always use the 'incl' and the 'lens' parameters.

Without that, Augeas will autoload all of the files defined in its lenses. On an empty VM that can take up to 1 second.

Here is my base test file:

    :::puppet
    $logrotate_file = '/etc/logrotate.d/httpd'
    augeas {
     'logrotate-httpd':
        context => "/files${logrotate_file}/rule/",
        changes => [
          'set schedule daily',
          'set rotate 6',
          'set compress compress',
        ],
    }

It takes 0.91 seconds:

    :::text
    # puppet apply test.pp
    Notice: Compiled catalog for localhost in environment production in 0.14 seconds
    Notice: Finished catalog run in 0.91 seconds

If I specify the file and the lens:

    :::puppet
    $logrotate_file = '/etc/logrotate.d/httpd'
    augeas {
     'logrotate-httpd':
        context => "/files${logrotate_file}/rule/",
        incl    => $logrotate_file,
        lens    => 'Logrotate.lns',
        changes => [
          'set schedule daily',
          'set rotate 6',
          'set compress compress',
        ],
    }

It takes 0.08 seconds:

    :::text
    # puppet apply test.pp
    Notice: Compiled catalog for localhost in environment production in 0.13 seconds
    Notice: Finished catalog run in 0.08 seconds

Note that this is linear. Augeas will load all its know files for each of the resources,
so you will lose one second for each resource without these arguments.
