# syntax=docker/dockerfile:1.2

# Copyright 2021 Authors of Cilium
# SPDX-License-Identifier: Apache-2.0

# BUILDPLATFORM is an automatic platform ARG enabled by Docker BuildKit.
# Represents the platform where the build is happening, do not mix with
# TARGETARCH

# Stage 1: install dnsperf and its build dependencies
FROM docker.io/library/alpine:3.18.2@sha256:82d1e9d7ed48a7523bdebc18cf6290bdb97b82302a8a9c27d4fe885949ea94d1 as dnsperf-builder

ARG DNSPERF_VERSION=2.13.0

RUN apk update \
    && apk add curl tar \
    && apk add build-base gcc libtool ldns-dev ck-dev nghttp2-dev openssl-dev

# Install dnsperf
RUN curl -L https://www.dns-oarc.net/files/dnsperf/dnsperf-${DNSPERF_VERSION}.tar.gz --output dnsperf-${DNSPERF_VERSION}.tar.gz \
    && tar zxvf dnsperf-${DNSPERF_VERSION}.tar.gz \
    && cd dnsperf-${DNSPERF_VERSION}  \
    && ./configure \
    && make \
    && make install

# Stage 2: install needed binaries
FROM docker.io/library/alpine:3.18.2@sha256:82d1e9d7ed48a7523bdebc18cf6290bdb97b82302a8a9c27d4fe885949ea94d1
# Copy dnsperf binary from the previous stage
COPY --from=dnsperf-builder /usr/local/bin/dnsperf /usr/bin/dnsperf
RUN apk add --no-cache curl iputils bind-tools tcpdump  \
    && apk add --no-cache ldns-dev libssl3 libcrypto3 nghttp2-libs # explicit dependencies for dnsperf

ENTRYPOINT ["/usr/bin/curl"]
