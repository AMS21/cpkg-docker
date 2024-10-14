ARG TAG

FROM fedora:$TAG

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN set -eux; \
    yum update -y; \
    yum install dnf git -y; \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --no-modify-path -y; \
    rm -rf /tmp/* /var/tmp/*;

ENTRYPOINT ["/bin/bash"]