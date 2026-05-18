# docker-octo-sts

A container image of [octo-sts](https://github.com/octo-sts/app)'s `cmd/app`, the Security Token Service for GitHub Apps.

octo-sts ships no official container image and has no Dockerfile in its repository, so the image is built from source and hosted at `ghcr.io/fohte/octo-sts`.

## Versioning

The octo-sts version to build is pinned by the `OCTO_STS_VERSION` ARG in the [`Dockerfile`](./Dockerfile). Renovate tracks it via the `go` datasource and opens update PRs.

## Build and publish

[`.github/workflows/build.yml`](./.github/workflows/build.yml) builds the image.

- PR: verifies only that the build succeeds (no push)
- push to main: publishes `ghcr.io/fohte/octo-sts:<OCTO_STS_VERSION>`

The image is published only with the octo-sts version tag; no `:latest` tag is added. Consumers must reference a fixed version.

## ghcr package visibility

A newly published GitHub Packages package is private by default, regardless of the repository visibility. To allow unauthenticated pulls, change the `octo-sts` package to public once after the first publish via the GitHub UI (Package settings -> Change visibility). GitHub provides no API for this.
