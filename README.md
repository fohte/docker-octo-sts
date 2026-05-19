# docker-octo-sts

[![Build image](https://github.com/fohte/docker-octo-sts/actions/workflows/build.yml/badge.svg)](https://github.com/fohte/docker-octo-sts/actions/workflows/build.yml)
[![Version](https://ghcr-badge.egpl.dev/fohte/octo-sts/latest_tag?label=version)](https://github.com/fohte/docker-octo-sts/pkgs/container/octo-sts)

A container image of [octo-sts](https://github.com/octo-sts/app)'s `cmd/app`, the Security Token Service for GitHub Apps.

octo-sts ships no official container image and has no Dockerfile in its repository, so the image is built from source and hosted at `ghcr.io/fohte/octo-sts`.

## Versioning

The octo-sts version to build is pinned by the `OCTO_STS_VERSION` ARG in the [`Dockerfile`](./Dockerfile). Renovate tracks it via the `go` datasource and opens update PRs.

The image is published only with the octo-sts version tag (for example `v0.7.1`); no `:latest` tag is added.

The version tag is **mutable**. Changes to the `Dockerfile` or to the base images (golang, distroless) trigger a rebuild and re-push under the same tag, so a given tag may point to different digests over time. Immutability is guaranteed by the digest (`sha256:...`), not by the tag. Consumers should pin by digest (see [Consuming the image](#consuming-the-image)).

## Build and publish

[`.github/workflows/build.yml`](./.github/workflows/build.yml) builds the image.

- PR: verifies only that the build succeeds (no push)
- push to main: publishes `ghcr.io/fohte/octo-sts:<OCTO_STS_VERSION>`

On push to main, the published image is hardened for supply-chain integrity:

- A SLSA build provenance attestation and an SBOM attestation are attached to the image.
- The image digest is signed with [cosign](https://github.com/sigstore/cosign) keyless signing, bound to this repository's build workflow via GitHub OIDC (no key management).
- The `org.opencontainers.image.revision` label records the source commit SHA, so the originating commit is recoverable from a digest even when the tag is reused.

## Consuming the image

Pin by digest so the reference is immutable even if the tag is later re-pushed:

```
ghcr.io/fohte/octo-sts:v0.7.1@sha256:<digest>
```

Renovate's `docker` datasource updates both the tag and the digest.

Verify the cosign signature against this repository's build workflow identity:

```sh
cosign verify \
  --certificate-identity=https://github.com/fohte/docker-octo-sts/.github/workflows/build.yml@refs/heads/main \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  ghcr.io/fohte/octo-sts:v0.7.1@sha256:<digest>
```
