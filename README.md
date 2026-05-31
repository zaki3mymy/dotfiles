# dotfiles

開発環境の初期設定をする。
設定はdotfilesの管理ツールである[chezmoi](https://github.com/twpayne/chezmoi)によって行う。

```shell
chezmoi init --apply zaki3mymy
nix run nixpkgs#home-manager -- switch \
  --flake ~/.config/home-manager#zaki3mymy \
  --extra-experimental-features "nix-command flakes"
```
