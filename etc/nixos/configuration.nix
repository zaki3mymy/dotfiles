# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "zaki3mymy";

  # https://zenn.dev/link/comments/20383debda9496
  wsl.interop.includePath = false;
  wsl.wslConf.interop.appendWindowsPath = false;

  users.users.zaki3mymy = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  environment.systemPackages = [
    pkgs.vim
    pkgs.chezmoi
    pkgs.xdg-utils
  ];
  environment.sessionVariables = rec {
    # WSLでターミナルからブラウザを開く設定
    BROWSER = "/mnt/c/Windows/System32/rundll32.exe url.dll,FileProtocolHandler";
  };

  time.timeZone = "Asia/Tokyo";

  system.activationScripts.myScript = {
    text = ''
      # https://zenn.dev/junkor/articles/cf64671f4fc637
      if [ ! -S "$XDG_RUNTIME_DIR/wayland-0" ]; then
          ln -s /mnt/wslg/runtime-dir/wayland-0* "$XDG_RUNTIME_DIR"
      fi
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
