ARG TAG

FROM debian:$TAG

ENV DEBIAN_FRONTEND=noninteractive \
    RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

ARG OLD_RELEASE=false

RUN set -eux; \
    if [ "$OLD_RELEASE" = "true" ]; then \
        sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list; \
        sed -i s/security.debian.org/archive.debian.org/g /etc/apt/sources.list; \
        sed -i s/stretch-updates/stretch/g /etc/apt/sources.list; \
    fi; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install apt ca-certificates curl gcc gcc-multilib git -y --no-install-recommends; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    apt-get remove curl -y --auto-remove; \
    apt-get clean; \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*;