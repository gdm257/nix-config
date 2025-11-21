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
    # Process
    pstree
    systemd
    libcgroup
  ];

  # ==== Process programs ====
  programs.htop.enable = true;
}
