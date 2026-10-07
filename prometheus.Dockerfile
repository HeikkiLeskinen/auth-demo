FROM prom/prometheus:v3.14.0

COPY entrypoint.sh /entrypoint.sh
USER root
RUN chmod +x /entrypoint.sh
USER nobody

ENTRYPOINT ["/entrypoint.sh"]
