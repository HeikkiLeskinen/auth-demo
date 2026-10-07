#!/bin/sh
# Renders prometheus.yml from env vars at container start (Prometheus has no
# native env-var interpolation) so the Aiven Thanos receive credentials in
# PROMETHEUS_RECEIVER never sit in a file on disk in the image or repo.
set -eu

: "${PROMETHEUS_RECEIVER:?PROMETHEUS_RECEIVER must be set (see .env)}"

cat > /etc/prometheus/prometheus.yml <<EOF
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: jaeger-collector-metrics
    static_configs:
      - targets: ["jaeger:8888"]
  - job_name: aggregated-trace-metrics
    static_configs:
      - targets: ["jaeger:8889"]

remote_write:
  - url: "${PROMETHEUS_RECEIVER}"
EOF

exec /bin/prometheus --config.file=/etc/prometheus/prometheus.yml
