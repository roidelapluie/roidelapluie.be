+++
title = "Prometheus and DST"
date = 2017-11-09T22:17:47+01:00
lang = "en"
categories = ["monitoring"]
tags = ["prometheus"]
slug = "prometheus-dst"

+++

[Prometheus](https://prometheus.io) only deals with GMT. It does not even try to
do something else. But, when you want to compare your business metrics with your
usual traffic, you need to take DST into account.

Here is my take on the problem. Note that I am in TZ=Europe/Brussels. We had DST
on October 29.

Let's say that I want to compare one metric with the same metric 2 weeks ago. In
this example, the metric would be `rate(app_requests_count{env="prod"}[5m])`.
If we are the 1st of December, we need to look back 14 days. But, if we are the
1st of November, we need to look back 14 days + 1 hour. DST happened on October
29.

To achieve that, we will take advantage of Prometheus [recording
rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/)
and [functions](https://prometheus.io/docs/prometheus/latest/querying/functions/).
This example is based on Prometheus 2.0.

First, I setup a record rule that tells me when I need to add an extra hour:

```
- record: dst
  expr: |
    0*(month() < 12) + 0*(day_of_month() < 13) + 0*(year() == 2017)
  labels:
    when: 14d
```

That metric `dst{when="14d"}` will be 0 until the 13th of November, and will have no value
otherwise. If you really care, you can play with the `hour()` function as well.

Then, I create a second rule with two different `offset` and a `or`. Note that
in a recording group, prometheus computes the rules sequentially.

```
- record: app_request_rate
  expr: |
    (
      sum(dst{when="14d"})
      + (
         sum(
          rate(
           app_requests_count{env="prod"}[5m]
           offset 337h
          )
         )
         or vector(0)
        )
    )
    or
    (
     sum(
      rate(
       app_requests_count{env="prod"}[5m]
       offset 14d)
      )
      or vector(0)
    )
  labels:
    when: 14d
```

Let's analyze this.


The recording rule is split in two parts by a `or`:


```
    (
      sum(dst{when="14d"})
      + (
         sum(
          rate(
           app_requests_count{env="prod"}[5m]
           offset 337h
          )
         )
         or vector(0)
        )
    )
```

```
    (
     sum(
      rate(
       app_requests_count{env="prod"}[5m]
       offset 14d)
      )
      or vector(0)
    )
```

If the first part does not return any value, then we get the second part.

The second part is easy, so let's start with it:

- We sum the 5min rates of app_requests_count, env=prod, 14 days ago.
- If we get no metrics (e.g. Prometheus was down) we get 0.


The first part is however a bit more complex. Part of it is like the second part,
but with an offset of 14d+1h (337h).

Now, to detect if we need the first of the second offset, we add `sum(dst{when="14d"})`
to  the first part. When we need to add an extra hour, then the value of `sum(dst{when="14d"})` is 0.
Otherwise, there is no value and prometheus falls back to the second part of the rule.

Note: in this rule, the `sum` in `sum(dst{when="14d"})` is
here to remove the labels, and allow the `+` operation.

It is a bit tricky ; but it should do the job. I think I will also in the future
create recording rules for `day_of_month()`, `month()` and `year()`, so I can
apply an offset to their values.

I will probably revisit this in March 2018...
