# syntax=docker/dockerfile:1

# renovate: datasource=go depName=github.com/octo-sts/app
ARG OCTO_STS_VERSION=v0.7.1

FROM golang:1.26.3-bookworm AS build

# グローバル ARG はビルドステージ内で再宣言しないと参照できない。
ARG OCTO_STS_VERSION

# distroless 上で動かすため CGO を無効にして静的バイナリを作る。
ENV CGO_ENABLED=0

RUN go install "github.com/octo-sts/app/cmd/app@${OCTO_STS_VERSION}"

FROM gcr.io/distroless/static-debian12:nonroot

# GitHub にこのイメージとリポジトリを紐付けさせ、Packages ページからリポジトリへ辿れるようにする。
LABEL org.opencontainers.image.source="https://github.com/fohte/docker-octo-sts"

COPY --from=build /go/bin/app /usr/bin/octo-sts

ENTRYPOINT ["/usr/bin/octo-sts"]
