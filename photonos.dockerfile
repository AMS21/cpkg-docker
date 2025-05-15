ARG TAG=latest

FROM photon:$TAG

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -eux; \
    tdnf update -y; \
    tdnf install binutils gcc git glibc-devel linux-api-headers openssl-devel zlib-devel -y; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    . "/usr/local/cargo/env"; \
    rustup install nightly; \
    cargo install cargo-tarpaulin; \
    tdnf remove binutils glibc-devel linux-api-headers openssl-devel zlib-devel -y; \
    tdnf clean all; \
    rm -rf /tmp/* /var/tmp/*;