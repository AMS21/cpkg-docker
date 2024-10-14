ARG TAG=latest

FROM amazonlinux:$TAG

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -eux; \
    yum update -y; \
    yum install dnf gcc git -y; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    yum autoremove -y; \
    yum clean all; \
    rm -rf /tmp/* /var/tmp/*;