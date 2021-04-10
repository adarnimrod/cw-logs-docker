FROM python:3.9-alpine3.13
# hadolint ignore=DL3013
RUN pip install --no-cache-dir --progress-bar=off \
        awscli-cwlogs \
        template \
    && \
    install -d -o nobody -g root -m 755 /var/awslogs/etc/
COPY --chown=root:root config /etc/aws/
COPY --chown=root:root entrypoint /usr/local/bin/
COPY --chown=root:root awslogs.conf /var/awslogs/etc/awslogs.conf.j2
COPY --chown=root:root deduce_aws_region /usr/local/bin/
USER nobody
ENV AWS_CONFIG_FILE="/etc/aws/config" \
    LOG_GROUP_NAME="" \
    LOG_STREAM_NAME="" \
    LOG_FILE=""
ENTRYPOINT ["entrypoint"]
CMD ["aws", "logs", "push", "--config-file", "/tmp/config"]
HEALTHCHECK CMD pgrep python || exit 1
