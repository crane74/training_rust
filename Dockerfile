FROM rust:1-bullseye

# タイムゾーンを日本に設定
ENV TZ=Asia/Tokyo

# インフラ整備
RUN apt update && apt upgrade -y  \
    && apt install -y tree \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# starshipの導入
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes && \
    echo eval "$(starship init bash)" >> ~/.bashrc

# Rust便利ツールの追加
RUN cargo install cargo-edit \
    && cargo install cargo-watch \
    && rustup component add rustfmt \
    && rustup component add clippy

WORKDIR /usr/src/app
