+++
title = "CalDAV, Open-Source and Android"
lang = "en"
categories = ["Android"]
tags = ["CalDAV", "zimbra", "calendar", "planet-inuits"]
slug = "caldav-android"
date = "2014-08-15T07:38:54"
+++

At [Inuits](https://www.inuits.eu), we are using [Zimbra](https://www.zimbra.com/community/) as mail and calendaring solution.

In the past, it used to be very difficult to synchronize the calendar with android phones.
The calendar supports ics and CalDAV exports, but none of these solutions was working on android.

## ICS

Synchronizing the calendar with ICS had several downsides:

* You need to create a share of the calendar
* It is read-only

So I quickly gave up that possibility.

## CalDAV

[CalDAV](http://caldav.calconnect.org/) is the protocol I preferred, because
it was native on Zimbra, and I could add/modify appointments directly on the phone.

### CalDAV-Sync

The first solution available is dmfs' [CalDAV-Sync](http://dmfs.org/caldav/). But
the application is closed source. The developer has been promising to open source if for years,
but nothing has changed yet about that part.

### aCal

[aCal](https://f-droid.org/repository/browse/?fdfilter=caldav&fdid=com.morphoss.acal)
was also a solution, but it was not integrated with the android calendaring system and the interface
was not really usable. Native integration with the android calendaring stack was
something I really wanted.

### CalDAV Sync Adapter

The next candidate that arrived on the market was [CalDAV Sync Adapter](https://f-droid.org/repository/browse/?fdid=org.gege.caldavsyncadapter).
It worked pretty well but it has some gotcha's that prevented me to see all my calendar.

By the time, it was also only read-only (this could have changed now).

### DavDroid

And then came the ultimate solution: [DavDroid](http://davdroid.bitfire.at/what-is-davdroid). Open-Source and available on [f-droid](https://f-droid.org/repository/browse/?fdfilter=davdroid&fdid=at.bitfire.davdroid), it worked OOTB with our setup. It supports two-way sync and is fully integrated with the calendaring stack of my android.


## Conclusion

There are may apps here, because CalDAV is not supported by android by default. I've chosen DavDroid because it was fitting my needs:

* integration with android calendaring
* open-source
* working correctly.

The 3 other options did only pick two of these criteria's.
