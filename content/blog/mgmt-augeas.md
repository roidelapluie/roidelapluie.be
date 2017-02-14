+++
date = "2017-02-14T20:34:13+01:00"
title = "Augeas resource for mgmt"
slug = "mgmt-augeas"
tags = ["automation","planet-inuits"]
categories = ["Linux"]
lang = "en"

+++

Last week, I joined the [mgmt](https://github.com/purpleidea/mgmt) hackathon,
just after Config Management Camp Ghent. It helped me understanding how mgmt
actually works and that helped me to introduce two improvements in the codebase:
prometheus support, and an augeas resource.

I will blog later about the prometheus support, today I will focus about the
Augeas resource.

## Defining a resource

Currently, mgmt does not have a DSL, it only uses plain yaml.

Here is how you define an Augeas resource:

```
---
graph: mygraph
resources:
  augeas:
  - name: sshd_config
    lens: Sshd.lns
    file: "/etc/ssh/sshd_config"
    sets:
      - path: X11Forwarding
        value: no
edges:
```

As you can see, the augeas resource takes several parameters:

- lens: the lens file to load
- file: the path to the file that we want to change
- sets: the paths/values that we want to change


Setting file will create a Watcher, which means that each time you change that
file, mgmt will check if it is still aligned with what you want.

## Code

The code can be found there: https://github.com/purpleidea/mgmt/pull/128/files

We are using go bindings for Augeas: https://github.com/dominikh/go-augeas/
Unfortunately, those bindings only support a recent version of Augeas. It was
needed to vendor it to make it build on travis.

## Future plans

Future plans regarding this resource is to add some parameters, probably a
parameter to use as Puppet "onlyif" parameter, and a "rm" parameter.
