# docker-octo-sts

[![Build image](https://github.com/fohte/docker-octo-sts/actions/workflows/build.yml/badge.svg)](https://github.com/fohte/docker-octo-sts/actions/workflows/build.yml)
[![Version](https://ghcr-badge.egpl.dev/fohte/octo-sts/latest_tag?label=version)](https://github.com/fohte/docker-octo-sts/pkgs/container/octo-sts)

A container image of [octo-sts](https://github.com/octo-sts/app)'s `cmd/app`, the Security Token Service for GitHub Apps.

octo-sts ships no official container image and has no Dockerfile in its repository, so the image is built from source and hosted at `ghcr.io/fohte/octo-sts`.

## Versioning

The octo-sts version to build is pinned by the `OCTO_STS_VERSION` ARG in the [`Dockerfile`](./Dockerfile). Renovate tracks it via the `go` datasource and opens update PRs.

## Build and publish

[`.github/workflows/build.yml`](./.github/workflows/build.yml) builds the image.

- PR: verifies only that the build succeeds (no push)
- push to main: publishes `ghcr.io/fohte/octo-sts:<OCTO_STS_VERSION>`

The image is published only with the octo-sts version tag; no `:latest` tag is added. Consumers must reference a fixed version.
