{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nix
    nix-derivation
    nix-init
    nix-tree
    nix-visualize
    nixpacks
    nixos-generators
    nixos-shell
    niv
    nurl
    nvd
    disko
    extra-container
  ];
}
