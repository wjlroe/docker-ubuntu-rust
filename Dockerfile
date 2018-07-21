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

ENV RUST_NIGHTLY_VERSION=2018-07-18

RUN rustup install nightly

ENV RUSTFMT_PREVIEW_VERSION=2018-07-02

RUN rustup component add rustfmt-preview --toolchain nightly
RUN rustup run nightly rustfmt --version

RUN echo "$PATH"
RUN rustc --version
RUN rustup run nightly rustc --version
