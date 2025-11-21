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
    # DevOps
    bit
    gitui
    gitu
    elfutils
    elfkickers
    elf-info
    devbox
    devspace
    devpod
  ];

  # ==== DevOps programs ====
  programs.git.enable = true;
  programs.distrobox = {
    enable = true;
  };
}
