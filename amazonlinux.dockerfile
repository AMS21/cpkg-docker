ARG TAG=latest

FROM amazonlinux:$TAG

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

ARG FLATPAK_SUPPORT=true

RUN set -eux; \
    yum update -y; \
    yum install dnf gcc git -y; \
    if [ "${FLATPAK_SUPPORT}" = "true" ]; then \
        yum install flatpak -y; \
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; \
    fi; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    yum autoremove -y; \
    yum clean all; \
    rm -rf /tmp/* /var/tmp/*;