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
    busybox
    uutils-coreutils-noprefix
    coreutils
    util-linux
    findutils

    firejail
    mosh
    openssh
    powershell
    wsl-open
    xdg-utils
  ];
}
