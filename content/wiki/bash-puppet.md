+++
title = "Switching between Puppet modules in bash"
date = "2016-02-24T11:48:27"
+++


```bash
mod(){
    cd "${PWD//modules*}modules/$1"
}
_mod(){
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="$(ls "${PWD//modules*}modules")"

    if [ $prev == "mod" ]
    then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi
}
complete -F _mod mod
```

Usage:

```
$ cd /home/foo/puppet/modules/puppet
$ pwd
/home/foo/puppet/modules/puppet
$ mod corosync
$ pwd
/home/foo/puppet/modules/corosync
$ cd manifests
$ pwd
/home/foo/puppet/modules/corosync/manifests
$ mod puppetdb
$ pwd
/home/foo/puppet/modules/puppetdb
```
