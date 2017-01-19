+++
title = "Paludis, a package manager"
lang = "en"
categories = ["Linux"]
tags = ["exherbo", "packaging", "planet-inuits"]
slug = "paludis"
date = "2014-02-02T21:24:44"
aliases = ["/paludis.html"]
+++

This weekend, the [Fosdem](http://fosdem.org) was still full of geeks and a lot of
discussions happened. [Package managers](http://www.slideshare.net/dberkholz/is-distributionlevel-package-management-obsolete)
were still in the discussions, while a lot of projects try to fix their problems:

* [FPM](https://github.com/jordansissel/fpm)
* [tito](https://github.com/dgoodwin/tito)
* [bower](https://github.com/bower/bower)
* [omnibus](https://github.com/opscode/omnibus-chef)
* [tar](https://www.gnu.org/software/tar/) :-)

Let me explain you some stuff about the [Exherbo](http://exherbo) package manager, [Paludis](http://paludis.exherbo.org/).

It is a performant package manager, which build packages from source, and it does
not solve all the traditional problems related to the package managers.

But look at the following elements:

### Chose your build options

Like in Gentoo, packages can be built with different use cases, depending on
the use you want. And you have that choice by default, in every package, meaning
that rebuilding with different options is not complicated, it is just routine.

### Build from SCM

You can build your packages directly from the last (git|svn|hg|bazaar) release, and still having it
tracked in your package manager. You also have the choice to rebuild each week from
the latest scm revision. Installing from latest scm is as easy as any other version (if
the scm information is packaged of course).

### No tarball, just how to package

The format of the software packages in Exherbo is plaintext. It contains the
links to download, the licencing information, the different steps to execute,
and any other useful information.

### Use upstreams like rubygem, github, pypi easily

There are a lot of exlibs, some kind of libraries for packages. By using

    require github

You will automatically fetch the right package on github, given the name of the
package and the revision. You can pass parameters to that class like the suffix or,
in the case of github, the user name.

### Decentralize

Using Exherbo often implies having a lot of repositories. A repository is a git repository.

You have an ::unavailable repository that contains the packages listed in all the repositories.

If you don't have the repositories to install the package you want, then this
repository will tell you in which repository you can find it.

A [public gerrit](http://galileo.mailstation.de/gerrit) instance takes care of QA, together
with jenkins.

### Multiple slots

Need python 2.7 and 3.3? Need php 5.3 and 5.4? Just install both, by specifying a
slot: php:5.3 php:5.4 will be considered like different packages. Installing php will
install only one slot.

On libraries, like python libraries, you can chose for which version of python you want
to that library, or you can select multiple. If you want PIL for python 2.7 and python 3
it is perfectly possible.

### Keep history of what was packaged and what is not

Sometimes you want something to ba packaged or you do not want to maintain a package anymore.
Two special repositories, ::graveyard and ::unwritten, contains a list of packages that
have been deleted or that have not been written yet.

### A package is not only a bunch of files

In Exherbo, users and group are also packaged. No need to create a user in a pre or post script.

### Package your make install

If you really have no time to write a good package, you can import a package in the package manager.

In that case, it will end in a ::unpackaged repository. You need to use

    make DESTDIR=myimage install

And then you can import the install directory in the package manager, with a version, and
of course with sanity checks. That way you can detect conflicts, uninstall easily, etc.

## Don't patch

Or only if the patch fixes compilation. It is best to send the patches upstream instead
of just patching at the distribution level.

## Conclusion

There is a lot of great ideas there. A lot of them are existing in other
distributions like Gentoo or Archlinux. But the slots, the options, easy working
with upstreams like rubygems and other stuff are not going to reach easily the larger
distributions soon.

