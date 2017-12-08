FROM ubuntu:yakkety
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
ENV RUST_VERSION=1.22.1

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y

ENV PATH /root/.cargo/bin:$PATH

ENV RUST_NIGHTLY_VERSION=2017-12-06

RUN rustup install nightly

RUN CFG_RELEASE_CHANNEL=nightly rustup run nightly cargo install --force rustfmt-nightly

RUN echo "$PATH"
RUN rustc --version
RUN rustup run nightly rustc --version
