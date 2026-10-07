FROM jaegertracing/jaeger:2.20.0

COPY config-spm.yaml /etc/jaeger/config.yml

# Jaeger UI
EXPOSE 16686
# jaeger_query internal gRPC
EXPOSE 16685
# OTLP gRPC receiver
EXPOSE 4317
# OTLP HTTP receiver
EXPOSE 4318
# Jaeger internal telemetry (scraped by Prometheus)
EXPOSE 8888
# spanmetrics connector's Prometheus exporter (scraped by Prometheus)
EXPOSE 8889

ENTRYPOINT ["/cmd/jaeger/jaeger-linux", "--config", "/etc/jaeger/config.yml"]
