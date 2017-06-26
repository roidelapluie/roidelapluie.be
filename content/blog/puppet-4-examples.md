+++
title = "Puppet 4 types and best practices"
lang = "en"
categories = ["Automation"]
tags = ["automation", "planet-inuits", "puppet"]
slug = "puppet-4-types"
date = "2015-09-15T00:04:38"
+++

I have given a talk last week for the Belgian Puppet User Group about Puppet 4
and I would like to post here some practices I want to share with you, in
order to have the cleanest Puppet code.

This can apply to all your local modules (not with the one you share with
Puppet 3 users).

### Type all the parameters

Each parameter should have a type. You can use the `Optional` type but you
should try to avoid some types as much as possible:

* `Variant`: because then you have to recheck the type after in your manifest.
* `Data` `Scalar`: it is way to generic and makes it hard to know what is behind.

Bad:
```Puppet
class demo::server (
  $ensure,
  $manage_service,
  $password,
){}
```

```Puppet
class demo::server (
  Enum['running', 'stopped'] $ensure,
  $manage_service,
  $password,
){}

```

Good:

```Puppet
class demo::server (
  Enum['running', 'stopped'] $ensure,
  Boolean $manage_service,
  String[8] $password,
){}

```

### Use complete types as much as possible

Avoid `Hash`, `Array`, `NotUndef`, `Optional` without parameters.

Try to always define the content of a `Hash` or an `Array`. `Struct` and `Tuple`
can help you with that.

Bad:
```Puppet
class demo::server (
    Hash $extra_parameters,
    Array $databases,
){}
```

```Puppet
class demo::server (
    Hash[String, Hash] $extra_parameters,
    Array $databases,
){}
```

Good:
```Puppet
class demo::server (
    Hash[String[1], Hash[String[1], String[1]]] $extra_parameters,
    Array[String[1]] $databases,
){}

```

### Define basic parameters like length and minimum value

In most of the cases, you do not want empty `String`. You should in most of the
cases use `String[1]`. The same applies for `Integer`: most of the case you want
integers being greater than 0. Use `Integer[0]` to do so.

Bad:
```Puppet
class demo::server(
  String $username,
  Array[String] $packages,
){}
```

Good:
```Puppet
class demo::server(
  String[4] $username,
  Array[String[1], 1] $packages,
){}
```
### Use the right type

* Never use `Variant[Type, Undef]`, use `Optional` directly.
* If you have a limited number of choices, use an `Enum`. Unless the number of
  choices it too important and reduce visibility. In that case think about `Pattern`
  if possible.
* Do not check the type again in the manifest itself.

```Puppet
class demo::server(
  Variant[String, Undef] $remote_host,
  Enum['httpd', 'mysql', 'ntp', 'mariadb', 'dhcpd'] $packages,
){}
```

```Puppet
class demo::server(
  Optional[String[1]] $remote_host,
  String[3] $packages,
){}
```

