+++
title = "The LibreOffice Calc 1024 columns bug"
lang = "en"
categories = ["Open-Source"]
tags = ["libreoffice", "office", "planet-inuits"]
slug = "libreoffice-calc-1024-columns"
date = "2015-04-20T21:51:52"
+++

Sometimes it is sad to see some quite important bugs that last in time.

One of the last one I hit is a limitation in LibreOffice Calc. It does not support
[calc spreadsheet with more that 1024 columns](https://bugs.documentfoundation.org/show_bug.cgi?id=50916).

That bug was already [opened in 2008](https://bz.apache.org/ooo/show_bug.cgi?id=86049) in OpenOffice.

It is really a blocker bug for people that receive spreadsheets that have a lof of columns. For example I have
seen a spreadsheet with one column per day. After 3 years it could not be opened by libreoffice (>1024 columns).

A short fix is to change the maximum number of columns but this would increase memory consumption for every opened spreadsheet. And it is not trivial for everyone to [recompile libreoffice](https://wiki.documentfoundation.org/Development/BuildingOnLinux). Here is how you update to 2048:

    ::patch
    diff --git a/sc/inc/address.hxx b/sc/inc/address.hxx
    index f6650d4..f1699af 100644
    --- a/sc/inc/address.hxx
    +++ b/sc/inc/address.hxx
    @@ -58,7 +58,7 @@ const SCSIZE   SCSIZE_MAX   = ::std::numeric_limits<SCSIZE>::max();
     // The maximum values. Defines are needed for preprocessor checks, for example
     // in bcaslot.cxx, otherwise type safe constants are preferred.
     #define MAXROWCOUNT_DEFINE 1048576
    -#define MAXCOLCOUNT_DEFINE 1024
    +#define MAXCOLCOUNT_DEFINE 2048
     
     // Count values
     const SCROW       MAXROWCOUNT    = MAXROWCOUNT_DEFINE;

Of course there are also alternatives like [gnumeric](http://www.gnumeric.org/) or [kcells](https://userbase.kde.org/KCells) that supports large spreadsheets, if they are simple enough.
