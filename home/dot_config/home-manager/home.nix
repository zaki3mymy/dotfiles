{
  pkgs,
  config,
  lib,
  ...
}:
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
  };

  home.activation.waylandSocket = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ln -sf /mnt/wslg/runtime-dir/wayland-0 "$XDG_RUNTIME_DIR/wayland-0"
    run ln -sf /mnt/wslg/runtime-dir/wayland-0.lock "$XDG_RUNTIME_DIR/wayland-0.lock"
  '';

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
    gnumake
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
    tflint

    # Cloud
    awscli2

    # JavaScript / TypeScript
    nodejs
    pnpm

    # AI
    claude-code
  ];
}
