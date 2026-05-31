{ pkgs, config, ... }:
{
  home.username = "zaki3mymy";
  home.homeDirectory = "/home/zaki3mymy";
  home.stateVersion = "25.11";

  # zshを有効化
  programs.zsh = {
    enable = true;
    dotDir = "${config.home.homeDirectory}/.config/zsh"; # chezmoiの設定を活かすためにnix管理の.zshrcはこっちで管理する

    zsh-abbr = {
      enable = true;
    };

    envExtra = ''
      # chezmoiの.zshrcを活かすためにこの設定が必要
      export ZDOTDIR="$HOME"
    '';
    loginExtra = ''
      # WSLg Wayland socket symlinks
      if [ -d /mnt/wslg/runtime-dir ]; then
        for sock in /mnt/wslg/runtime-dir/wayland-0*; do
          target="$XDG_RUNTIME_DIR/$(basename $sock)"
          [ ! -e "$target" ] && ln -s "$sock" "$target"
        done
      fi
    '';
  };

  # デフォルトシェルをzshに
  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  # zsh-abbr は非商用利用のみ(cc-by-nc-sa-40 hl3)なので特別に許可する
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "zsh-abbr"
      "claude-code"
    ];

  home.packages = with pkgs; [
    actionlint
    curl
    direnv
    git
    git-secrets
    gh
    neovim
    pre-commit
    ripgrep
    tmux
    unzip
    vim
    zsh
    zsh-abbr
    zip

    # Nix
    home-manager
    nixfmt

    # dotfiles
    chezmoi
    stylua
    shellcheck
    shfmt

    # Python
    uv

    # Go
    go
    gopls
    golangci-lint

    # IaC
    tenv

    # JavaScript / TypeScript
    pnpm

    # AI
    claude-code
  ];
}
