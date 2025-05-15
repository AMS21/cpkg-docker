ARG TAG=latest

FROM cachyos/cachyos:$TAG

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -eux; \
    pacman -Syu flatpak gcc git --noconfirm; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    . "/usr/local/cargo/env"; \
    rustup install nightly; \
    cargo install cargo-tarpaulin; \
    rm -rf /tmp/* /var/tmp/*;

ENTRYPOINT ["/bin/bash"]