+++
title = "Puppet: no such file to load -- json (LoadError)"
lang = "en"
date = "2014-10-07T08:27:11"
+++

A Ruby & Json error

```bash
[root@localhost ~]# puppet agent --test
/usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `gem_original_require': no such file to load -- json (LoadError)
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `require'
        from /usr/lib/ruby/site_ruby/1.8/puppet/module.rb:3
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `gem_original_require'
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `require'
        from /usr/lib/ruby/site_ruby/1.8/puppet/parser/files.rb:1
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `gem_original_require'
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `require'
        from /usr/lib/ruby/site_ruby/1.8/puppet/parser/templatewrapper.rb:1
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `gem_original_require'
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `require'
        from /usr/lib/ruby/site_ruby/1.8/puppet/parser/scope.rb:6
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `gem_original_require'
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `require'
        from /usr/lib/ruby/site_ruby/1.8/puppet/parser/methods.rb:2
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `gem_original_require'
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `require'
        from /usr/lib/ruby/site_ruby/1.8/puppet/parser/ast/method_call.rb:2
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `gem_original_require'
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `require'
        from /usr/lib/ruby/site_ruby/1.8/puppet/parser/ast.rb:115
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `gem_original_require'
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `require'
        from /usr/lib/ruby/site_ruby/1.8/puppet/parser/parser.rb:11
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `gem_original_require'
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `require'
        from /usr/lib/ruby/site_ruby/1.8/puppet/parser.rb:4
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `gem_original_require'
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `require'
        from /usr/lib/ruby/site_ruby/1.8/puppet.rb:270
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `gem_original_require'
        from /usr/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:36:in `require'
        from /usr/lib/ruby/site_ruby/1.8/puppet/util/command_line.rb:12
        from /usr/bin/puppet:7:in `require'
        from /usr/bin/puppet:7
```

```bash
[root@localhost ~]# rpm -qi rubygem-json
Name        : rubygem-json                 Relocations: / 
Version     : 1.8.0                             Vendor: Florian Frank
Release     : 1                             Build Date: Wed 05 Jun 2013 10:44:15 AM CEST
Install Date: Tue 07 Oct 2014 08:13:41 AM CEST      Build Host: build.inuits.eu
Group       : Languages/Development/Ruby    Source RPM: rubygem-json-1.8.0-1.src.rpm
Size        : 1214696                          License: Ruby
Signature   : (none)
Packager    : <jenkins@inuits.eu>
URL         : http://flori.github.com/json
Summary     : This is a JSON implementation as a Ruby extension in C.
Description :
This is a JSON implementation as a Ruby extension in C.
```

```bash
[root@localhost ~]# yum install ruby-json
Loaded plugins: security
Setting up Install Process
Resolving Dependencies
--> Running transaction check
---> Package ruby-json.x86_64 0:1.5.5-3.el6 will be installed
--> Processing Dependency: rubygem-json = 1.5.5-3.el6 for package: ruby-json-1.5.5-3.el6.x86_64
--> Finished Dependency Resolution
Error: Package: ruby-json-1.5.5-3.el6.x86_64 (Puppetlabs-deps)
           Requires: rubygem-json = 1.5.5-3.el6
           Installed: 1:rubygem-json-1.8.0-1.noarch (@internal)
               rubygem-json = 1:1.8.0-1
           Available: rubygem-json-1.4.6-1.el6.x86_64 (Puppetlabs-deps)
               rubygem-json = 1.4.6-1.el6
           Available: rubygem-json-1.4.6-2.el6.x86_64 (Puppetlabs-deps)
               rubygem-json = 1.4.6-2.el6
           Available: rubygem-json-1.5.5-1.el6.x86_64 (Puppetlabs-deps)
               rubygem-json = 1.5.5-1.el6
           Available: rubygem-json-1.5.5-3.el6.x86_64 (Puppetlabs-deps)
               rubygem-json = 1.5.5-3.el6
           Available: rubygem-json-1.6.6-2.el6.x86_64 (upstream)
               rubygem-json = 1.6.6-2.el6
           Available: 1:rubygem-json-1.5.4-1.noarch (internal)
               rubygem-json = 1:1.5.4-1
           Available: 1:rubygem-json-1.6.6-1.noarch (internal)
               rubygem-json = 1:1.6.6-1
           Available: 1:rubygem-json-1.7.6-1.noarch (internal)
               rubygem-json = 1:1.7.6-1
 You could try using --skip-broken to work around the problem
 You could try running: rpm -Va --nofiles --nodigest
```



```bash
[root@localhost ~]# yum shell
Loaded plugins: security
Setting up Yum Shell
> remove rubygem-json
Setting up Remove Process
> install rubygem-json-1.5.5-3.el6
Setting up Install Process
> install ruby-json
> run
--> Running transaction check
---> Package ruby-json.x86_64 0:1.5.5-3.el6 will be installed
---> Package rubygem-json.x86_64 0:1.5.5-3.el6 will be installed
---> Package rubygem-json.noarch 1:1.8.0-1 will be erased
--> Finished Dependency Resolution

====================================================================================
 Package             Arch          Version             Repository              Size
====================================================================================
Installing:
 ruby-json           x86_64        1.5.5-3.el6         Puppetlabs-deps        9.1 k
 rubygem-json        x86_64        1.5.5-3.el6         Puppetlabs-deps        763 k
Removing:
 rubygem-json        noarch        1:1.8.0-1           @internal        1.2 M

Transaction Summary
====================================================================================
Install       2 Package(s)
Remove        1 Package(s)

Total download size: 772 k
Is this ok [y/N]: y
Downloading Packages:
(1/2): ruby-json-1.5.5-3.el6.x86_64.rpm                      | 9.1 kB     00:00
(2/2): rubygem-json-1.5.5-3.el6.x86_64.rpm                   | 763 kB     00:00
------------------------------------------------------------------------------------
Total                                               5.3 MB/s | 772 kB     00:00
Running rpm_check_debug
Running Transaction Test
Transaction Test Succeeded
Running Transaction
  Installing : rubygem-json-1.5.5-3.el6.x86_64                                  1/3
  Installing : ruby-json-1.5.5-3.el6.x86_64                                     2/3
  Cleanup    : 1:rubygem-json-1.8.0-1.noarch                                    3/3
  Verifying  : ruby-json-1.5.5-3.el6.x86_64                                     1/3
  Verifying  : rubygem-json-1.5.5-3.el6.x86_64                                  2/3
  Verifying  : 1:rubygem-json-1.8.0-1.noarch                                    3/3

Removed:
  rubygem-json.noarch 1:1.8.0-1

Installed:
  ruby-json.x86_64 0:1.5.5-3.el6          rubygem-json.x86_64 0:1.5.5-3.el6

Finished Transaction
> Leaving Shell
```


```bash
[root@localhost ~]# puppet agent --test
Info: Retrieving pluginfacts
```

The yum shell command avoids the removal of the puppet package.
