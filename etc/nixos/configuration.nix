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
    extraGroups = [
      "wheel"
      "podman"
    ];
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
    pkgs.podman-compose
  ];
  environment.sessionVariables = rec {
    # WSLでターミナルからブラウザを開く設定
    BROWSER = "/mnt/c/Windows/System32/rundll32.exe url.dll,FileProtocolHandler";
  };

  time.timeZone = "Asia/Tokyo";

  # https://wiki.nixos.org/wiki/Podman
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
