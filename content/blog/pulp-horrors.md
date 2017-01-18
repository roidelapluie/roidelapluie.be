+++
title = "A classical pulp upgrade ...."
lang = "en"
categories = ["Linux"]
tags = ["centos", "pulp", "planet-inuits", "mongodb"]
slug = "pulp-horror-fest"
date = "2014-10-08T09:27:12"
+++

Yesterday I did upgrade a pulp instance from pulp 2.2 to pulp 2.4. Here is my story...

Upgrading pulp seems very very simple. You update the RPMs then you run the migration script, `pulp-manage-db`. Well, at least that's the theory.

#### First step: packages changes

The [release note](http://pulp-user-guide.readthedocs.org/en/latest/release-notes/2.4.x.html) tell us a couple of things: some packages to install, some configuration files to save...

So here we go:

* Install some qpid packages
* Upgrade mongodb to 2.4
* Set `auth=no` is needed in `/etc/qpid/qpidd.conf`
* Downgrade `m2crypto` to use distribution packages

For the moment, everything is good.


#### Second step: Run the migrations


Here the troubles begin.

There is a first fail in the migration, but hopefully the fix is documented, and in 2 minutes my search engine told me what to do:

```
find /var/lib/pulp/working/repos/ -path '*/yum_importer' -type d -exec rm -rf '{}' \;
```

Apparently it is because this pulp instance was migrated from a pulp 1 to a pulp 2 in the past.


The migration fails a second time. And there is a [ticket](https://bugzilla.redhat.com/show_bug.cgi?format=multiple&id=1016612) for that.

Here are the logs (these one come from the ticket but I got exactly the same behaviour):

```
# pulp-manage-db 
Beginning database migrations.
Migration package pulp.server.db.migrations is up to date at version 4
Migration package pulp_puppet.plugins.migrations is up to date at version 0
Applying pulp_rpm.migrations version 8
Migration to pulp_rpm.migrations version 8 complete.
Applying pulp_rpm.migrations version 9
Migration to pulp_rpm.migrations version 9 complete.
Applying pulp_rpm.migrations version 10
Migration to pulp_rpm.migrations version 10 complete.
Applying pulp_rpm.migrations version 11
Applying migration pulp_rpm.migrations.0011_new_importer failed.  See log for
details.
2013-10-08 11:52:52,924 db:CRITICAL: Applying migration
pulp_rpm.migrations.0011_new_importer failed.
2013-10-08 11:52:52,925 db:CRITICAL: 'NoneType' object has no attribute 'text'
2013-10-08 11:52:52,998 db:CRITICAL: Traceback (most recent call last):
  File "/usr/lib/python2.6/site-packages/pulp/server/db/manage.py", line 79, in
    migrate_database update_current_version=not options.test)
  File "/usr/lib/python2.6/site-packages/pulp/server/db/migrate/models.py",
    line 161, in apply_migration migration.migrate()
  File "/usr/lib/python2.6/site-packages/pulp_rpm/migrations/0011_new_importer.py",
    line 29, in migrate _migrate_collection(type_id)
  File "/usr/lib/python2.6/site-packages/pulp_rpm/migrations/0011_new_importer.py",
    line 56, in _migrate_collection package['sourcerpm'] = format_element.find('sourcerpm').text
AttributeError: 'NoneType' object has no attribute 'text'
```

The bug report was reported by one of my colleagues, and it is marked as CLOSED CURRENTRELEASE. Sorry but this is not fixed.

Hopefully there is a workaround in the ticket: you need to do some changes in `0011_new_importer.py` and replace

```python
package['sourcerpm'] = format_element.find('sourcerpm').text
```
by
```python
try:
    package['sourcerpm'] = format_element.find('sourcerpm').text
except AttributeError:
    package['sourcerpm'] = ''
```

At this point I start disliking pulp, but I was not at the end of my surprises.

I re-run the migration scripts. That step goes well. But the it is another one that is failing:

```
Applying migration pulp_rpm.plugins.migrations.0016_new_yum_distributor failed.

Halting migrations due to a migration failure.
Error publishing repository centos-5-x86_64.  More than one distribution found.
Traceback (most recent call last):
  File "/usr/lib/python2.6/site-packages/pulp/server/db/manage.py", line 111, in main
    _auto_manage_db(options)
  File "/usr/lib/python2.6/site-packages/pulp/server/db/manage.py", line 157, in _auto_manage_db
    migrate_database(options)
  File "/usr/lib/python2.6/site-packages/pulp/server/db/manage.py", line 86, in migrate_database
    update_current_version=not options.test)
  File "/usr/lib/python2.6/site-packages/pulp/server/db/migrate/models.py", line 161, in apply_migration
    migration.migrate()
  File "/usr/lib/python2.6/site-packages/pulp_rpm/plugins/migrations/0016_new_yum_distributor.py", line 59,

    _re_publish_repository(repo, d)
  File "/usr/lib/python2.6/site-packages/pulp_rpm/plugins/migrations/0016_new_yum_distributor.py", line 165

    publisher.publish()
  File "/usr/lib/python2.6/site-packages/pulp/plugins/util/publish_step.py", line 323, in publish
    self.process_lifecycle()
  File "/usr/lib/python2.6/site-packages/pulp/plugins/util/publish_step.py", line 92, in process_lifecycle
    step.process()
  File "/usr/lib/python2.6/site-packages/pulp/plugins/util/publish_step.py", line 148, in process
    self.initialize()
  File "/usr/lib/python2.6/site-packages/pulp_rpm/plugins/distributors/yum/publish.py", line 666, in initia

    raise Exception(msg)
Exception: Error publishing repository centos-5-x86_64.  More than one distribution found.
```

More than one distribution found. And now? How do I delete the useless distributions?

Indeed that repo has several distributions: 5.9, 5.10, 5.11... But at this time of the migration,
the pulp server refuses to work because it is not migrated.

So I can not delete the distributions. And I can't run the migration. So I can not use pulp. So I can not delete the distribution. Which means I can not do the migration. And I can not use pulp. So I can not delete the distributions. And I can not run the migration...

Let's apply the previous workaround on that situation. In `0016_new_yum_distributor.py`, let's change:

```python
publisher.publish()
```
by
```python
try:
    publisher.publish()
except Exception as e:
    print "Ignoring exception: %s" % e
```

So the migration will be considered as done, but the repos won't be republished.

And indeed it worked as expected. I could now try to find the double distributions:

```
pulp-admin rpm repo content distribution --repo-id centos-5-x86_64
```

And ... a new surprise: pulp only returns ONE distribution. So you don't know how many of them are in the repository.

So I needed to delete the distributions *one by one*, then re-publish the repository.

Some more services were needed also: `pulp_celerybeat`  `pulp_resource_manager` and  `pulp_workers`.

And, at the end, it worked.
