{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    rustup
  ];
}
