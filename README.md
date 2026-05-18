# docker-octo-sts

[octo-sts](https://github.com/octo-sts/app) (GitHub App 用の Security Token Service) の
`cmd/app` をビルドしたコンテナイメージ。home-k8s クラスタ上の Deployment が pull する。

octo-sts は公式のコンテナイメージを一切配布しておらず、リポジトリに Dockerfile も無いため、
ソースから自前でビルドして `ghcr.io/fohte/octo-sts` にホストする。

## バージョン管理

ビルド対象の octo-sts のバージョンは [`Dockerfile`](./Dockerfile) の `OCTO_STS_VERSION`
ARG で固定する。Renovate が `go` datasource でこの値を追跡し、更新 PR を出す。

## ビルドと publish

[`.github/workflows/build.yml`](./.github/workflows/build.yml) がイメージをビルドする。

- PR: ビルドの成否のみ検証する (push しない)
- main push: `ghcr.io/fohte/octo-sts:<OCTO_STS_VERSION>` を publish する

イメージは octo-sts のバージョンタグのみで publish し、`:latest` は付けない。pull する側は
必ず固定バージョンを参照する。

## ghcr パッケージの公開設定

home-k8s クラスタは imagePullSecret 無しでこのイメージを pull するため、`octo-sts`
パッケージを public にする必要がある。GitHub Packages はパッケージ作成後の可視性変更を
API で提供していないため、初回 publish 後に GitHub UI で 1 度だけ public に設定する
(Package settings -> Change visibility)。
