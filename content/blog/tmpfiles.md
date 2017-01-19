+++
title = "An Augeas lens for tmpfiles.d"
lang = "en"
categories = ["Automation"]
tags = ["augeas", "systemd", "puppet"]
slug = "augeas-tmpfiles"
date = "2015-07-31T21:45:27"
+++

I have sent recently a [Pull Request][1] to the [Augeas][2] project. That PR
is about a new lens, a [tmpfiles.d][3] lens.

If you want some background, check my [slides][5] (or the [video][6]) for the
talk about [Augeas][2] I have given last november at Puppetcamp London.

When systemd is in charge of the temporary directories of a server, some directories
(`/tmp`, `/run`, `/var/tmp`) are mounted in a tmpfs and are just empty at boot time.

What happens for a service, like MariaDB, which has to create the file `/run/maria/maria.pid`
(fictional example) if `/run/maria` does not exist and `/run` it not writable by its user?
How does systemd handle that?

The answer is [tmpfiles.d][3]. It consists of a bunch of config files, each line
describing a directory, a link, a value that has to be written to a file... I let
you parse the manpage for more details.

I wanted to get an augeas lense that can parse those files, so I can manage each line
of those files il a more clever way than just templating the whole file.

Here is how to create a directory in /run in CentOS 6:

    file {
      '/run/maria':
        ensure => directory,
    }

And in CentOS 7 + my augeas lens:

    augeas {
      "tmpfiles.d-new-${path}":
        changes => [
          "set /files/etc/tmpfiles.d/my.conf/01/type 'd'",
          "set /files/etc/tmpfiles.d/my.conf/01/path '${path}'",
          "set /files/etc/tmpfiles.d/my.conf/01/mode '${mode}'",
          "set /files/etc/tmpfiles.d/my.conf/01/uid '${owner}'",
          "set /files/etc/tmpfiles.d/my.conf/01/gid '${group}'",
        ],
        onlyif => "match /files/etc/tmpfiles.d/my.conf/*[path = '${path}']/path size < 1",
        tag    => ['tmpfiles.d-augeas'],
    }
    augeas {
      "tmpfiles.d-${path}":
        context => "/files/etc/tmpfiles.d/my.conf/*[path = '${path}']",
        changes => [
          "set type 'd'",
          "set gid '${group}'",
          "set uid '${owner}'",
          "set mode '${mode}'",
        ],
        tag => ['tmpfiles.d-augeas'],
    }
    exec {"systemd-tmpfiles-${path}":
      command  => '/usr/bin/systemd-tmpfiles --create',
      creates  => $path,
      tag      => 'na-systemd-tmpfiles',
    }
    file {
      $path:
        ensure    => directory,
        owner     => $owner,
        group     => $group,
        mode      => $mode,
        noop      => true,
    }
    Augeas<|tag == 'tmpfiles.d-augeas'|> -> Exec["systemd-tmpfiles-${path}"]
    Exec<|tag == 'na-systemd-tmpfiles'|> -> File[$path]

A bunch of stuff to notice here:

 * You have to run a command (`/usr/bin/systemd-tmpfiles --create`) after changing the files
 * I have put the actual file location in 'noop' mode, just for backward compatibility
 * The `<||>` is not for collected resources but for local resources (collected are `<<||>>`)

You can download the lens (`.aug` file) from my pull request and put it into
the `lib/augeas/lenses` directory of the module to get it to work.

In the future this will probably be a lot more simple because I might write an
[augeasprovider][4] for that.

[1]: https://github.com/hercules-team/augeas/pull/269
[2]: http://augeas.net/
[3]: http://www.freedesktop.org/software/systemd/man/tmpfiles.d.html
[4]: http://augeasproviders.com/
[5]: http://www.slideshare.net/roidelapluie/augeas-swiss-knife-resources-for-your-puppet-tree
[6]: https://www.youtube.com/watch?v=Gghl1t1okW4
