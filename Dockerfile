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
       -qqy \
       --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ENV RUST_ARCHIVE=rust-1.18.0-x86_64-unknown-linux-gnu.tar.gz
ENV RUST_DOWNLOAD_URL=https://static.rust-lang.org/dist/$RUST_ARCHIVE

RUN mkdir /rust
WORKDIR /rust

RUN curl -fsOSL $RUST_DOWNLOAD_URL \
    && curl -s $RUST_DOWNLOAD_URL.sha256 | sha256sum -c - \
    && tar -C /rust -xzf $RUST_ARCHIVE --strip-components=1 \
    && rm $RUST_ARCHIVE \
    && ./install.sh --without=rls,rust-docs

ENV PATH /root/.cargo/bin:$PATH

RUN echo "$PATH"
