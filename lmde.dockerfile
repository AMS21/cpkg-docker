ARG TAG=6

FROM linuxmintd/lmde$TAG-amd64

ENV DEBIAN_FRONTEND=noninteractive \
    RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

ARG OLD_RELEASE=false

RUN set -eux; \
    if [ "${OLD_RELEASE}" = "true" ]; then \
        for file in /etc/apt/sources.list.d/*.list; do \
            sed -i '/security.debian.org/d' ${file}; \
            sed -i 's/deb.debian.org/archive.debian.org/g' ${file}; \
        done; \
    fi; \
    apt update; \
    apt upgrade -y; \
    apt install ca-certificates curl flatpak gcc git -y --no-install-recommends; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    apt-get remove curl -y --auto-remove; \
    apt-get clean; \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*;