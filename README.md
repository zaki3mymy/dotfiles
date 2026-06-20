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
