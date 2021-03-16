FROM alpine:3.10
RUN apk add --no-cache curl iputils
ENTRYPOINT ["/usr/bin/curl"]
