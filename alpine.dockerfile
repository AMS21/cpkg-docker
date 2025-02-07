ARG TAG=latest

FROM alpine:$TAG

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

ARG FLATPAK_SUPPORT=true

RUN set -eux; \
    apk update && apk upgrade; \
    apk add curl gcc git musl-dev; \
    if [ "${FLATPAK_SUPPORT}" = "true" ]; then \
        apk add flatpak; \
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; \
    fi; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    apk del --purge curl; \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*;