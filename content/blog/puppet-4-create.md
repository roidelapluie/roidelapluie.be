+++
title = "Puppet 4 create_resource killer"
lang = "en"
categories = ["Automation"]
tags = ["automation", "planet-inuits", "puppet"]
slug = "puppet-4-create-resources"
date = "2015-09-15T23:22:42"
+++

Puppet 4 brings very nice features that will definitely kill the `create_resources`
function.

### Parameters as a hash

```Puppet
$parameters = {
  mode    => '0755',
  content => 'foo',
}

file {
  '/tmp/myfile':
    * => $parameters
}
```

It is the same as:

```Puppet
file {
  '/tmp/myfile':
    mode    => '0755',
    content => 'foo',
}
```

### Resource defaults

```Puppet
file {
  default:
    mode    => '0755',
    content => 'foo';
  '/tmp/my_file1':;
  '/tmp/my_file2':
    mode => '0644',
}
```

Is the same as:


```Puppet
file {
  '/tmp/my_file1':
    mode    => '0755',
    content => 'foo';
  '/tmp/my_file2':
    mode    => '0644',
    content => 'foo';
}
```

Or (but the scope is different):

```Puppet
File {
  mode    => '0755',
  content => 'foo';
}
file {
  '/tmp/my_file1':;
  '/tmp/my_file2':
    mode => '0644',
}
```


### Combining both of them

```Puppet
$parameters = {
  content => 'foo',
  ensure  => present,
}

$default = {
  noop => true,
  mode => '0644',
}

file {
  default:
    * => $default;
  '/tmp/my_file1':
    * => $parameters;
  '/tmp/my_file2':
    *    => $parameters;
    mode => '0755';
}
```

In a loop:

```Puppet
$parameters = {
  content => 'foo',
  ensure  => present,
}

$default = {
  noop => true,
  mode => '0644',
}

$files = ['/tmp/my_file1', '/tmp/my_file2']

$files.each | String $file_path | {
  file {
    default:
      * => $default;
    $file_path:
      * => $parameters
  }
}
```
