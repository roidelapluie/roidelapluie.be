+++
title = "Debugging resource failures with pcs"
lang = "en"
categories = ["Linux"]
tags = ["centos", "automation", "HA", "planet-inuits"]
slug = "pcs-resource-debug"
date = "2015-09-16T10:44:54"
+++

Here is a small script to debug pacemaker resource failures in EL7.

It is more helpful than `pcs resource debug-start` and is based on
[the clusterlabs wiki](http://clusterlabs.org/wiki/Debugging_Resource_Failures).

All you need is to adapt `resource=` and `operation=`. You can also make an
executable script that will take them as first and second parameter, as below:

```bash
#!/bin/bash
resource=$1
operation=$2

# Unmanage the resource
pcs resource unmanage $resource

# OCF_ROOT is needed and might be OS dependent
export OCF_ROOT=/usr/lib/ocf

# Setting variables for the parameters
eval $(pcs resource show $resource|
grep Attributes:|
awk '{$1=""; print}'|
tr " " "\n"|
grep .|
xargs -I X echo export OCF_RESKEY_X|
sed 's/=\(.*\)/="\1"/')

# Run the RA now that we have the right environment
bash -x /usr/lib/ocf/resource.d/$(pcs resource show $resource|
sed -n 1p|
sed 's@.*provider=\(.*\) type=\(.*\))@\1/\2@') $operation
```

Once done do not forget to do `pcs resource manage $resource`
