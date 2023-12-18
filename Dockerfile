# syntax=docker/dockerfile:1.2

# Copyright 2021 Authors of Cilium
# SPDX-License-Identifier: Apache-2.0

FROM registry.k8s.io/pause:3.9@sha256:7031c1b283388d2c2e09b57badb803c05ebed362dc88d84b480cc47f72a21097 as pause

# BUILDPLATFORM is an automatic platform ARG enabled by Docker BuildKit.
# Represents the platform where the build is happening, do not mix with
# TARGETARCH
FROM docker.io/library/alpine:3.18.5@sha256:34871e7290500828b39e22294660bee86d966bc0017544e848dd9a255cdf59e0
COPY --from=pause /pause /usr/bin/pause
RUN apk add --no-cache curl iputils bind-tools tcpdump
ENTRYPOINT ["/usr/bin/curl"]
