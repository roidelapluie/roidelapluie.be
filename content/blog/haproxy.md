+++
title = "Goodbye haproxy_exporter"
date = 2019-11-27T10:00:00+01:00
lang = "en"
categories = ["prometheus"]
tags = ["haproxy"]
slug = "haproxy-prometheus"

+++

[HAProxy 2.0](https://www.haproxy.org) contains, among other improvements, the
ability to expose prometheus metrics natively.

As I am building [HAProxy 2.0 and 2.1
rpm's](https://copr.fedorainfracloud.org/coprs/roidelapluie/haproxy/builds/), I
wanted to try it out and move away from the [haproxy_exporter](https://github.com/prometheus/haproxy_exporter/).

While the haproxy\_exporter is developed by the Prometheus team, and therefore a
high quality exporter, there is good reasons to move to the HAProxy native
prometheus exporter:

- Performance
- New metrics
- Operations (no need to manage an exporter + the `up` metric represents
  haproxy)
- Security (no need to expose the stats csv)

## Metrics

Gone but can be calculated better with queries:

- haproxy_backend_current_server
- haproxy_backend_current_session_rate
- haproxy_backend_http_connect_time_average_seconds
- haproxy_backend_http_queue_time_average_seconds
- haproxy_backend_http_response_time_average_seconds
- haproxy_backend_http_total_time_average_seconds
- haproxy_frontend_current_session_rate
- haproxy_server_current_session_rate

Replaced by better metrics:

- haproxy_backend_up: replaced by haproxy_backend_status
- haproxy_server_up: replaced by haproxy_frontend_status with more values (0=STOP, 1=UP, 2=FULL, 2=MAINT, 3=DRAIN, 4=NOLB)

Gone because they were linked to the exporter itself:

- haproxy_exporter_build_info
- haproxy_exporter_csv_parse_failures
- haproxy_exporter_total_scrapes
- go metrics

New metrics:

- haproxy_backend_active_servers
- haproxy_backend_backup_servers
- haproxy_backend_check_last_change_seconds
- haproxy_backend_check_up_down_total
- haproxy_backend_client_aborts_total
- haproxy_backend_connect_time_average_seconds
- haproxy_backend_connection_attempts_total
- haproxy_backend_connection_reuses_total
- haproxy_backend_downtime_seconds_total
- haproxy_backend_failed_header_rewriting_total
- haproxy_backend_http_cache_hits_total
- haproxy_backend_http_cache_lookups_total
- haproxy_backend_http_comp_bytes_bypassed_total
- haproxy_backend_http_comp_bytes_in_total
- haproxy_backend_http_comp_bytes_out_total
- haproxy_backend_http_comp_responses_total
- haproxy_backend_http_requests_total
- haproxy_backend_last_session_seconds
- haproxy_backend_loadbalanced_total
- haproxy_backend_max_connect_time_seconds
- haproxy_backend_max_queue_time_seconds
- haproxy_backend_max_response_time_seconds
- haproxy_backend_max_total_time_seconds
- haproxy_backend_queue_time_average_seconds
- haproxy_backend_requests_denied_total
- haproxy_backend_response_time_average_seconds
- haproxy_backend_responses_denied_total
- haproxy_backend_server_aborts_total
- haproxy_backend_total_time_average_seconds
- haproxy_frontend_connections_rate_max
- haproxy_frontend_denied_connections_total
- haproxy_frontend_denied_sessions_total
- haproxy_frontend_failed_header_rewriting_total
- haproxy_frontend_http_cache_hits_total
- haproxy_frontend_http_cache_lookups_total
- haproxy_frontend_http_comp_bytes_bypassed_total
- haproxy_frontend_http_comp_bytes_in_total
- haproxy_frontend_http_comp_bytes_out_total
- haproxy_frontend_http_comp_responses_total
- haproxy_frontend_http_requests_rate_max
- haproxy_frontend_intercepted_requests_total
- haproxy_frontend_responses_denied_total
- haproxy_process_active_peers
- haproxy_process_busy_polling_enabled
- haproxy_process_connected_peers
- haproxy_process_connections_total
- haproxy_process_current_backend_ssl_key_rate
- haproxy_process_current_connection_rate
- haproxy_process_current_connections
- haproxy_process_current_frontend_ssl_key_rate
- haproxy_process_current_run_queue
- haproxy_process_current_session_rate
- haproxy_process_current_ssl_connections
- haproxy_process_current_ssl_rate
- haproxy_process_current_tasks
- haproxy_process_current_zlib_memory
- haproxy_process_dropped_logs_total
- haproxy_process_frontent_ssl_reuse
- haproxy_process_hard_max_connections
- haproxy_process_http_comp_bytes_in_total
- haproxy_process_http_comp_bytes_out_total
- haproxy_process_idle_time_percent
- haproxy_process_jobs
- haproxy_process_limit_connection_rate
- haproxy_process_limit_http_comp
- haproxy_process_limit_session_rate
- haproxy_process_limit_ssl_rate
- haproxy_process_listeners
- haproxy_process_max_backend_ssl_key_rate
- haproxy_process_max_connection_rate
- haproxy_process_max_connections
- haproxy_process_max_fds
- haproxy_process_max_frontend_ssl_key_rate
- haproxy_process_max_memory_bytes
- haproxy_process_max_pipes
- haproxy_process_max_session_rate
- haproxy_process_max_sockets
- haproxy_process_max_ssl_connections
- haproxy_process_max_ssl_rate
- haproxy_process_max_zlib_memory
- haproxy_process_nbproc
- haproxy_process_nbthread
- haproxy_process_pipes_free_total
- haproxy_process_pipes_used_total
- haproxy_process_pool_allocated_bytes
- haproxy_process_pool_failures_total
- haproxy_process_pool_used_bytes
- haproxy_process_relative_process_id
- haproxy_process_requests_total
- haproxy_process_ssl_cache_lookups_total
- haproxy_process_ssl_cache_misses_total
- haproxy_process_ssl_connections_total
- haproxy_process_start_time_seconds
- haproxy_process_stopping
- haproxy_process_unstoppable_jobs
- haproxy_server_check_failures_total
- haproxy_server_check_last_change_seconds
- haproxy_server_check_up_down_total
- haproxy_server_client_aborts_total
- haproxy_server_connect_time_average_seconds
- haproxy_server_connection_attempts_total
- haproxy_server_connection_reuses_total
- haproxy_server_current_throttle
- haproxy_server_downtime_seconds_total
- haproxy_server_failed_header_rewriting_total
- haproxy_server_last_session_seconds
- haproxy_server_loadbalanced_total
- haproxy_server_max_connect_time_seconds
- haproxy_server_max_queue_time_seconds
- haproxy_server_max_response_time_seconds
- haproxy_server_max_total_time_seconds
- haproxy_server_queue_limit
- haproxy_server_queue_time_average_seconds
- haproxy_server_response_time_average_seconds
- haproxy_server_responses_denied_total
- haproxy_server_server_aborts_total
- haproxy_server_server_idle_connections_current
- haproxy_server_server_idle_connections_limit
- haproxy_server_total_time_average_seconds

## Enabling Prometheus support

HAProxy must be compiled with Prometheus support:

```shell
$ make TARGET=linux-glibc EXTRA_OBJS="contrib/prometheus-exporter/service-prometheus.o"
```

To enable those new metrics on a HAProxy 2.x (I reuse 9101, the port of the
exporter):

```haproxy
frontend prometheus
    bind 127.0.0.1:9101
    http-request use-service prometheus-exporter if { path /metrics }
```

You can set just the last line of course.

## Compatibility with the exporter

If you want to keep your old dashboards, here is what you need to know:

The haproxy\_exporter used backend or frontend as labels, where HAProxy uses the
proxy label. You can retain the old behaviour using Prometheus metrics relabelling:

```yaml
scrape_configs:
- job_name: haproxy
  static_configs:
    - targets: [127.0.0.1:9101]
  metric_relabel_configs:
  - source_labels: [__name__, proxy]
    regex: "haproxy_frontend.+;(.+)"
    target_label: frontend
    replacement: "$1"
  - source_labels: [__name__, proxy]
    regex: "haproxy_server.+;(.+)"
    target_label: backend
    replacement: "$1"
  - source_labels: [__name__, proxy]
    regex: "haproxy_backend.+;(.+)"
    target_label: backend
    replacement: "$1"
  - regex: proxy
    action: labeldrop
```

With that configuration you will have a painless migration to the native HAProxy
metrics!

## Conclusion

I was positively surprised to see that most of the metrics were still there, and
that we have access to a lot of new metrics! This is really a big step for
HAProxy monitoring.
