ARG TAG=latest

FROM photon:$TAG

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -eux; \
    tdnf update -y; \
    tdnf install gcc git -y; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    tdnf clean all; \
    rm -rf /tmp/* /var/tmp/*;