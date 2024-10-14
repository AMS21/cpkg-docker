ARG TAG=latest

FROM mageia:$TAG

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -eux; \
    dnf update -y; \
    dnf install gcc git -y; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    dnf autoremove -y; \
    dnf clean all; \
    rm -rf /tmp/* /var/tmp/*;