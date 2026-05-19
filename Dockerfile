# syntax=docker/dockerfile:1

# renovate: datasource=go depName=github.com/octo-sts/app
ARG OCTO_STS_VERSION=v0.7.1

FROM golang:1.26.3-bookworm AS build

# A global ARG must be re-declared inside a build stage to be referenced there.
ARG OCTO_STS_VERSION

# Build a static binary with CGO disabled so it runs on the distroless base.
ENV CGO_ENABLED=0

RUN go install "github.com/octo-sts/app/cmd/app@${OCTO_STS_VERSION}"

FROM gcr.io/distroless/static-debian12:nonroot

# Link this image to its repository so the Packages page points back here.
LABEL org.opencontainers.image.source="https://github.com/fohte/docker-octo-sts"

COPY --from=build /go/bin/app /usr/bin/octo-sts

ENTRYPOINT ["/usr/bin/octo-sts"]
