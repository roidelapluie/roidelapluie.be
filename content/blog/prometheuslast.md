+++
title = "Dealing with flapping metrics in prometheus"
date = 2019-02-21T10:56:16+01:00
lang = "en"
categories = ["monitoring"]
tags = ["prometheus"]
slug = "prometheus-last"

+++

[Prometheus](https://prometheus.io) allows you to get metrics from a lot of
systems.

We are integrated with third party suppliers that expose us a balance, an amount
of resources we can use.

That is exposed as the following metric:

`
available_sms{route="1",env="prod"} 1000
`

This is a gauge, therefore we can write an alerting rule like this:

```
- alert: No more SMS
  expr: |
    available_sms < 1000
```

That works well.. when the provider API is available. In our use case,
sometimes, the api is refusing access for 10 minutes. Which means that if our
balance is below 1000 we will get two tickets as the alert will start twice.

An alternative would be to do:

```
- alert: No more SMS
  expr: |
    max_over_time(available_sms[1h]) < 1000
```

Picking `min_over_time` means that the alert will be resolved only one hour
after the original result.
`max_over_time` means that the alert will be triggered one hour too late.


We use an alternative approach, which is to record the last known value:

```
- record: available_sms_last
  expr: available_sms or available_sms_last
- alert: No more SMS
  expr: |
    available_sms_last < 1000
- alert: No more SMS balance
  expr: |
    absent(available_sms)
  for: 1h
```

That rule will ensure that in case the api is not available, the
`available_sms_last` metric will contain the last known value. We can therefore alert on
that, without alerting too soon or too late! This is using [prometheus 1-to-1
vector matching](https://prometheus.io/docs/prometheus/latest/querying/operators/#vector-matching).

Another alert, on `absent(available_sms)` enables us to know when the api is
down for a long time.
