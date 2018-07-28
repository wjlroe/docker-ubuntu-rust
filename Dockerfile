FROM ubuntu:latest
MAINTAINER William Roe "git@wjlr.org.uk"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install \
       ca-certificates \
       curl \
       gcc \
       libc6-dev \
       python \
       git \
       ssh \
       tar \
       gzip \
       build-essential \
       -qqy \
       --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# This is only to force an update when changing this variable
ENV RUST_VERSION=1.27.2

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y

ENV PATH /root/.cargo/bin:$PATH

ENV RUSTFMT_PREVIEW_VERSION="0.6.1-stable (49279d71 2018-05-08)"

RUN rustup component add rustfmt-preview
RUN cargo fmt --version

RUN echo "$PATH"
RUN rustc --version
