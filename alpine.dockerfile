ARG TAG=latest

FROM alpine:$TAG

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -eux; \
    apk update && apk upgrade; \
    apk add curl gcc git musl-dev; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    apk del --purge curl; \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*;