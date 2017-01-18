+++
title = "Percona XtraBackup 2.2.10 is incompatible with MariaDB 10.0"
lang = "en"
categories = ["Linux"]
tags = ["mysql", "planet-inuits"]
slug = "xtrabackup-and-mariadb"
date = "2015-04-15T21:31:19"
+++

[Percona XtraBackup](http://www.percona.com/doc/percona-xtrabackup/2.2/) is
probably the most relevant open-source backup solution for both
[MySQL](http://www.mysql.com/) and [MariaDB](https://mariadb.org/). It has all
the required features that you need to backup your database, especially if you use innodb (or xtradb).

One of the features are Incremental backups. It is an easy way to get
a consistent backup of your databases in a short amount of time.

But the latest version of XtraBackup
([2.2.10](http://www.percona.com/doc/percona-xtrabackup/2.2/release-notes/2.2/2.2.10.html))
breaks that feature with MariaDB 10.0. And it is not a bug, it is a feature.
Let me explain: it is due to an old feature that was not enabled.

Two years ago (exactly), XtraBackup got a feature called [bitmap-based incremental backups](https://github.com/percona/percona-xtrabackup/commit/a37c7cbca557e94bb5f5ffe4ae02378dcf98daf7). But that feature was (at least partly) not working, as that feature was always disabled. It was fixed [recently](https://github.com/percona/percona-xtrabackup/commit/a39237dd1a4de653e205e63b81ae5c4c5659116d).

The fix enables that feature in MariaDB 10.0. When an incremental backup is done,
XtraBackup issues the following command:

    ::mysql
    FLUSH NO_WRITE_TO_BINLOG CHANGED_PAGE_BITMAPS

Which does not exist in MariaDB:

    You have an error in your SQL syntax; check the manual that corresponds to
    your MariaDB server version for the right syntax to use near
    CHANGED_PAGE_BITMAPS.

There are two upstream bugs for this: [one for XtraBackup](https://bugs.launchpad.net/percona-xtrabackup/+bug/1444541)
and [another one for MariaDB](https://mariadb.atlassian.net/browse/MDEV-7472).
It will probably not be fixed in MariaDB (at least not in a close future), but
we can reasonably expect that XtraBackup 2.2.11 will contain a fix for this.

### Command-line workaround

The recommended workaround for MariaDB is to use the `--incremental-force-scan` option
as [pointed out by Sergei Glushchenko](https://bugs.launchpad.net/percona-xtrabackup/+bug/1444541/comments/5).

### Patch for backward compatibility

The following patch allows you to break the feature detection to have backward
command-line compatibility:

     ::diff
     --- a/bin/innobackupex  2015-04-15 18:07:06.472692735 +0200
     +++ b/bin/innobackupex  2015-04-15 18:07:52.092927798 +0200
     @@ -4981,10 +4981,7 @@
          my $con = shift;

          if ($option_incremental) {
     -        $have_changed_page_bitmaps =
     -            mysql_get_one_value($con, "SELECT COUNT(*) FROM " .
     -                        "INFORMATION_SCHEMA.PLUGINS " .
     -                        "WHERE PLUGIN_NAME LIKE 'INNODB_CHANGED_PAGES'");
     +        $have_changed_page_bitmaps = 0;
          }

          if (!defined($con->{vars})) {

Please note that this patch is for the pre-compiled version of XtraBackup. In
the source tree, the file to patch is `storage/innobase/xtrabackup/innobackupex.pl`.

You should now be able to enjoy all the new changes of the latest version of
XtraBackup with MariaDB 10.0!
