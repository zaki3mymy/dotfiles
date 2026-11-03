# dotfiles

開発環境の初期設定をする。
設定はdotfilesの管理ツールである[chezmoi](https://github.com/twpayne/chezmoi)によって行う。

```shell
# dotfilesを展開
chezmoi init --apply zaki3mymy

# NixOSの場合
chezmoi cd && cp -b etc/nixos/configuration.nix /etc/nixos/configuration.nix
# WSL再起動

# パッケージのインストール
nix run nixpkgs#home-manager -- switch \
  --flake ~/.config/home-manager#zaki3mymy \
  --extra-experimental-features "nix-command flakes"
```

## Claude Code のクラウド環境

`claude-cloud/` はローカルには展開しない（chezmoi の管理外）。
クラウド環境のセットアップスクリプト（claude.ai/code の環境設定）に以下を書く。

```bash
#!/bin/bash
git clone --depth 1 https://github.com/zaki3mymy/dotfiles "$HOME/dotfiles" || true
bash "$HOME/dotfiles/claude-cloud/setup-nix-devshells.sh" || true
```

- `setup-nix-devshells.sh` は、`flake.nix` を持つリポジトリの devShell のツールを Nix ストアに取得するだけ
- PATH などの環境変数は、各リポジトリの SessionStart フック（`.claude/hooks/session-start.sh`）で設定する
- セットアップスクリプトはリポジトリの1つ上のディレクトリで始まるので、`cd` せずに呼ぶ
