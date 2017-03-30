+++
tags = ["Jenkins", "Testing", "Planet-inuits"]
date = "2017-03-30T21:33:11+02:00"
categories = ["Automation"]
lang = "en"
title = "Running Nightly jobs with Jenkins"
slug = "nightly-jobs-jenkins"

+++

Jenkins can spread the load of Jobs by using H instead of * in the cron fields.
It means that:

```
H 3 * * *
```

Means: Run between 3 and 4 am.

The minute will be decided by Jenkins, by applying a hash function over the job
name.

What about this one:

```
H H * * *
```

Means: Run once a day. The moment will be calculated by a Jenkins based on the
job name.

But what if I have hundreds of jobs, I want to run them once a day, but during
night? Something like:

```
H H(0-5) * * *
```

Means: Run the job once everyday between 12am and 6am.

But when you scale up your Jenkins, you want the jobs to run between e.g. 7pm
and 6am. Because you also want to use the hours before midnight.,

There is a BAD WAY to do it:

```
H H(0-6),H(19-23) H/2 * *
```

That would run the jobs in the morning and the evening, every 2 days. It is
complex and will not behave correctly at the end of months.


The GOOD WAY to do it is to set the timezone in the cron expression, something
which is [not documented yet](https://github.com/jenkinsci/jenkins/pull/1720).
It is there since Jenkins 1.615 so you probably have it in your Jenkins:

```
TZ=GMT+7
H H(0-10) * * *
```

What does this mean? In the timezone GMT+7, run the jobs once between 12am and
11 am. Which means between 7pm and 6am in my timezone.

```
$ date -d '0:00 GMT+7'
Wed Mar 29 19:00:00 CEST 2017
$ date -d '11:00 GMT+7'
Thu Mar 30 06:00:00 CEST 2017
```

It is a lot more simple syntax and is more reliable. Please note that the
validation (preview) below the Cron settings is not using that TZ
(I opened [JENKINS-43228](https://issues.jenkins-ci.org/browse/JENKINS-43228)
for this).
