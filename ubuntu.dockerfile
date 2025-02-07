ARG TAG=latest

FROM ubuntu:$TAG

ENV DEBIAN_FRONTEND=noninteractive \
    RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

ARG OLD_RELEASE=false
ARG FLATPAK_SUPPORT=true

RUN set -eux; \
    if [ "${OLD_RELEASE}" = "true" ]; then \
        sed -i 's|http://\([a-z0-9.-]*\)\.ubuntu.com/ubuntu|http://old-releases.ubuntu.com/ubuntu|' /etc/apt/sources.list; \
    fi; \
    apt update; \
    apt upgrade -y; \
    apt install ca-certificates curl gcc gcc-multilib git -y --no-install-recommends; \
    if [ "${FLATPAK_SUPPORT}" = "true" ]; then \
        apt install flatpak -y; \
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; \
    fi; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    apt-get remove curl software-properties-common -y --auto-remove; \
    apt-get clean; \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*;