ARG TAG=latest

FROM manjarolinux/base:$TAG

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -eux; \
    pacman -Syu gcc git pamac-gtk --noconfirm; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    rm -rf /tmp/* /var/tmp/*;

ENTRYPOINT ["/bin/bash"]