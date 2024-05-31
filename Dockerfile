# syntax=docker/dockerfile:1.2

# Copyright 2021 Authors of Cilium
# SPDX-License-Identifier: Apache-2.0

FROM registry.k8s.io/pause:3.10@sha256:ee6521f290b2168b6e0935a181d4cff9be1ac3f505666ef0e3c98fae8199917a as pause

# BUILDPLATFORM is an automatic platform ARG enabled by Docker BuildKit.
# Represents the platform where the build is happening, do not mix with
# TARGETARCH
FROM docker.io/library/alpine:3.20.0@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd
COPY --from=pause /pause /usr/bin/pause
RUN apk add --no-cache curl iputils bind-tools tcpdump
ENTRYPOINT ["/usr/bin/curl"]
