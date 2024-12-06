# syntax=docker/dockerfile:1.2

# Copyright 2021 Authors of Cilium
# SPDX-License-Identifier: Apache-2.0

FROM registry.k8s.io/pause:3.10@sha256:ee6521f290b2168b6e0935a181d4cff9be1ac3f505666ef0e3c98fae8199917a as pause

# BUILDPLATFORM is an automatic platform ARG enabled by Docker BuildKit.
# Represents the platform where the build is happening, do not mix with
# TARGETARCH
FROM docker.io/library/alpine:3.21.0@sha256:21dc6063fd678b478f57c0e13f47560d0ea4eeba26dfc947b2a4f81f686b9f45
COPY --from=pause /pause /usr/bin/pause
RUN apk add --no-cache curl iputils bind-tools tcpdump iproute2
ENTRYPOINT ["/usr/bin/curl"]
