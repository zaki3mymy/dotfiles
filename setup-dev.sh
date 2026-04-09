#!/bin/bash
# dotfilesの開発のためのセットアップ
uv tool install git+https://github.com/johnnymorganz/stylua
uv tool install pre-commit
apt install -y shellcheck

# shfmt v3.13.0+ が zsh をサポートしているため apt 版ではなく最新版を使用する
shfmt_version=$(curl -fsSL "https://api.github.com/repos/mvdan/sh/releases/latest" | jq -r '.tag_name')
curl -fsSL "https://github.com/mvdan/sh/releases/download/${shfmt_version}/shfmt_${shfmt_version}_linux_amd64" \
  -o /usr/local/bin/shfmt
chmod +x /usr/local/bin/shfmt

pre-commit install
