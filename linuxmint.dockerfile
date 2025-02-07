ARG TAG=22

FROM linuxmintd/mint$TAG-amd64

ENV DEBIAN_FRONTEND=noninteractive \
    RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

ARG FLATPAK_SUPPORT=true

RUN set -eux; \
    apt update; \
    apt upgrade -y; \
    apt install ca-certificates curl gcc gcc-multilib git -y --no-install-recommends; \
    if [ "${FLATPAK_SUPPORT}" = "true" ]; then \
        apt install flatpak -y; \
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; \
    fi; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    apt-get remove curl -y --auto-remove; \
    apt-get clean; \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*;