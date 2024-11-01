ARG TAG=kali-last-release

FROM kalilinux/$TAG

ENV DEBIAN_FRONTEND=noninteractive \
    RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -eux; \
    apt update; \
    apt upgrade -y; \
    apt install ca-certificates curl gcc gcc-multilib git -y --no-install-recommends; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    apt remove curl -y --auto-remove; \
    apt clean; \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*;