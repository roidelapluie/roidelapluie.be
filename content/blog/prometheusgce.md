+++
title = "Prometheus Google Compute Engine discovery example"
date = "2019-03-09T11:44:58+01:00"
lang = "en"
categories = ["monitoring"]
tags = ["prometheus"]
slug = "prometheus-gce"

+++

Here is a small example on how to use [Prometheus](https://prometheus.io) to
scrape your GCE instance.

I recommend you to look at [prometheus documentation][doc]
to see how you can pass the crendentials to your prometheus instance.

```
scrape_configs:
  - job_name: node_gce
    gce_sd_configs:
      - zone: europe-west1-b
        project: myproject
      - zone: europe-west1-d
        project: myproject
      - zone: europe-west1-c
        project: myproject
    relabel_configs:
      - source_labels: [__meta_gce_public_ip]
        target_label: __address__
        replacement: "${1}:9090"
      - source_labels: [__meta_gce_zone]
        regex: ".+/([^/]+)"
        target_label: zone
      - source_labels: [__meta_gce_project]
        target_label: project
      - source_labels: [__meta_gce_instance_name]
        target_label: instance
      - regex: "__meta_gce_metadata_(.+)"
        action: labelmap
```

Let's analyze it.

### Zones and projects

```
    gce_sd_configs:
      - zone: europe-west1-b
        project: project1
      - zone: europe-west1-d
        project: project1
      - zone: europe-west1-c
        project: project2
```

We have a job named node_gce, which has 3 `gce_sd_config` objects. One object is
attached to one zone and one project.

### Relabeling

#### Setting the address

This example will substitute the private ip by the public ip of your node, and
use the port 9090. `__address__` is a hidden used by prometheus to get the
address to scrape.

```
      - source_labels: [__meta_gce_public_ip]
        target_label: __address__
        replacement: "${1}:9090"
```

#### Zones and project

Now, let's get automatically a zone label, which will match the gce zone:

```
      - source_labels: [__meta_gce_zone]
        regex: ".+/([^/]+)"
        target_label: zone
```

Let's get a project label, too:

```
      - source_labels: [__meta_gce_project]
        target_label: project
```

#### Instance name

And a human readable instance name, that will match gce instance name:

```
      - source_labels: [__meta_gce_instance_name]
        target_label: instance
```

#### Metadata

The last part of the config will make every metadata of the instance a label in
prometheus:

```
      - regex: "__meta_gce_metadata_(.+)"
        action: labelmap
```

[doc]:https://prometheus.io/docs/prometheus/latest/configuration/configuration/#gce_sd_config
