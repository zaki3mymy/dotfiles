#!/bin/bash
# dotfilesの開発のためのセットアップ
uv tool install git+https://github.com/johnnymorganz/stylua
uv tool install pre-commit
apt install -y shellcheck shfmt

pre-commit install
