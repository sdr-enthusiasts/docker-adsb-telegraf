FROM telegraf:1.26 AS telegraf

RUN touch /tmp/emptyfile

FROM ghcr.io/sdr-enthusiasts/docker-baseimage:base

ENV \
    S6_KILL_GRACETIME=1000

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# add telegraf binary
COPY --from=telegraf /usr/bin/telegraf /usr/bin/telegraf

RUN set -x && \
    mkdir -p /etc/telegraf/telegraf.d && \
    # document telegraf version
    bash -ec "telegraf --version >> /VERSIONS" && \
    cat /VERSIONS

COPY rootfs/ /
