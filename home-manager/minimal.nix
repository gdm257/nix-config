{
  inputs,
  outputs,
  globals,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Shell

    # DevOps
    go-task

    # Downloader

    # File
    nix-tree

    # Kernel

    # Layer
    lilipod shadow

    # Network
    curl
    wget
    iproute2

    # Process

    # Text
  ];

  # ==== DevOps programs ====
  programs.jujutsu = {
    enable = true;
  };
  programs.uv = {
    enable = true;
  };
  programs.bun = {
    enable = true;
  };
  # programs.go = {
  #   enable = true;
  # };

  # ==== DevOps programs ====
  # programs.distrobox = {
  #   enable = true;
  # };

  # ==== File programs ====
  programs.eza = {
    enable = true;
    icons = "never";
    extraOptions = [ "--group-directories-first" ];
  };
  programs.fzf = {
    enable = true;
    # enableBashIntegration = false;
    # enableFishIntegration = false;
    # enableZshIntegration = false;
  };

}
